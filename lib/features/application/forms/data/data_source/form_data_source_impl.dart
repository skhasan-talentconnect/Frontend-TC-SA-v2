import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/application/forms/index.dart';

class FormDataSourceImpl implements FormDataSource {
  final _appStateProvider = getIt<AppStateProvider>();
  final _networkService = getIt<NetworkService>();
  Map<String, dynamic>? _ensureMap(dynamic value) {
    if (value == null) return null;
    if (value is Map<String, dynamic>) return value;
    if (value is String) {
      // convert id string -> minimal object expected by parser
      return {'_id': value};
    }
    // sometimes backend returns ObjectId-like with toString()
    try {
      return (value as dynamic).toJson?.call() as Map<String, dynamic>?;
    } catch (_) {}
    return null;
  }

  ResultFuture<List<Form>?> getFormsByApplication({
    required String applicationId,
    String? status,
  }) async {
    try {
      if (applicationId.trim().isEmpty) {
        return Left(
          APIException(message: "Missing applicationId", statusCode: 400),
        );
      }

      // endpoint: https://backend-tc-sa-v2.onrender.com/api/form/application/:applicationId
      final endpoint =
          '${Endpoints.baseUrl}form/application/$applicationId${status != null ? '?status=$status' : ''}';

      Request request = Request(
        method: RequestMethod.get,
        endpoint: endpoint,
        isSafeRoute: true,
      );

      final result = await _networkService.request(request);
      final raw = result.data as Map<String, dynamic>?;

      // data is expected in raw['data'] as a List
      final list =
          (raw != null && raw['data'] is List)
              ? (raw['data'] as List)
              : <dynamic>[];

      // helper to normalize fields that may be strings
      Map<String, dynamic>? _norm(dynamic maybe) {
        if (maybe == null) return null;
        if (maybe is Map<String, dynamic>) return maybe;
        if (maybe is String) return {'_id': maybe};
        return null;
      }

      final forms =
          list.map<Form>((item) {
            // item can be Map<String,dynamic> or something else
            final Map<String, dynamic> map = Map<String, dynamic>.from(
              item as Map,
            );
            // replace id strings by small maps so Form.fromJson won't try to cast String->Map
            if (map.containsKey('schoolId'))
              map['schoolId'] = _norm(map['schoolId']);
            if (map.containsKey('studId')) map['studId'] = _norm(map['studId']);
            if (map.containsKey('applicationId'))
              map['applicationId'] = _norm(map['applicationId']);
            if (map.containsKey('applicationForm'))
              map['applicationForm'] = _norm(map['applicationForm']);
            // If backend returns top-level keys differently (data nested) handle above accordingly.

            try {
              return Form.fromJson(map);
            } catch (e) {
              // In case Form.fromJson still fails, create a minimal Form manually
              return Form(
                sId: map['_id']?.toString(),
                // school / user / application might be null or partial.
              );
            }
          }).toList();

      return Right(forms);
    } catch (e) {
      return Left(APIException.from(e));
    }
  }

  @override
  ResultFuture<Form?> getFormById({required String formId}) async {
    Request request = Request(
      method: RequestMethod.get,
      endpoint: '/form/$formId',
      isSafeRoute: true,
    );

    try {
      final result = await _networkService.request(request);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final form = Form.fromJson(response['data'] as Map<String, dynamic>);
        return Right(form);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }

  @override
  ResultFuture<List<Form>?> getStudentForms() async {
    Request request = Request(
      method: RequestMethod.get,
      endpoint: '${Endpoints.formStudent}/${_appStateProvider.user?.sId}',
    );

    try {
      final result = await _networkService.request(request);
      final rawList = (result.data['data'] as List<dynamic>?) ?? [];

      final forms =
          rawList.map<Form>((raw) {
            // raw might be Map<String, dynamic> but inner fields may be String or Map
            final Map<String, dynamic> item =
                (raw is Map<String, dynamic>)
                    ? Map.from(raw)
                    : {'_id': raw.toString()};

            // Normalize nested fields that Form.fromJson expects as maps
            final schoolObj = _ensureMap(
              item['schoolId'] ?? item['school'],
            ); // some APIs use 'school'
            final studObj = _ensureMap(
              item['studId'] ?? item['user'] ?? item['stud'],
            ); // defensive
            final applicationObj = _ensureMap(
              item['applicationId'] ?? item['application'],
            );
            final applicationFormObj = _ensureMap(
              item['applicationForm'] ?? item['applicationFormId'],
            );

            // Replace into item so Form.fromJson sees maps
            if (schoolObj != null) item['schoolId'] = schoolObj;
            if (studObj != null) item['studId'] = studObj;
            if (applicationObj != null) item['applicationId'] = applicationObj;
            if (applicationFormObj != null)
              item['applicationForm'] = applicationFormObj;

            // Some fields may be strings (status) — fine.
            return Form.fromJson(item);
          }).toList();

      return Right(forms);
    } catch (e, s) {
      print('getStudentForms error: $e\n$s');
      return Left(APIException.from(e));
    }
  }

  @override
  ResultFuture<Form?> submitForm({
    required String applicationId,
    required String schoolId,
    required int amount,
    required String formId, // pass the pdf/form template id
  }) async {
    try {
      final studId = _appStateProvider.user?.sId ?? '';
      if (studId.isEmpty) {
        return Left(
          APIException(message: "Missing student id", statusCode: 400),
        );
      }

      final endpoint = '${Endpoints.baseUrl}form/$schoolId/$studId/$formId';

      Request request = Request(
        method: RequestMethod.post,
        endpoint: endpoint,
        body: {'applicationId': applicationId, 'amount': amount},
        isSafeRoute: true,
      );
      final result = await _networkService.request(request);
      final raw = result.data as Map<String, dynamic>? ?? {};
      print('submitForm raw response: ${raw.runtimeType} -> $raw');

      // Helper to parse stringified JSON if needed
      dynamic unwrap(dynamic v) {
        if (v is String) {
          try {
            final dec = jsonDecode(v);
            return unwrap(dec);
          } catch (_) {
            return v;
          }
        }
        return v;
      }

      dynamic unwrapped = unwrap(raw);

      if (unwrapped is Map<String, dynamic> && unwrapped.containsKey('data')) {
        unwrapped = unwrap(unwrapped['data']);
      }

      if (unwrapped is! Map<String, dynamic>) {
        print('submitForm: unwrapped is not a Map -> $unwrapped');
        return Right(null);
      }

      // Convert to mutable map copy
      final Map<String, dynamic> normalized = Map<String, dynamic>.from(
        unwrapped,
      );

      // If backend returns applicationForm (pdf id), map it to applicationId key expected by your model.
      if (normalized.containsKey('applicationForm') &&
          !normalized.containsKey('applicationId')) {
        final af = normalized['applicationForm'];
        // if applicationForm is an id string, keep it mapped under applicationId as minimal object
        if (af is String && af.isNotEmpty) {
          normalized['applicationId'] = {'_id': af};
        } else if (af == null) {
          normalized['applicationId'] = null;
        } else if (af is Map<String, dynamic>) {
          // if backend somehow populated object, pass-through
          normalized['applicationId'] = af;
        }
      }

      // Keys returned as plain strings that our model expects as objects — normalize them:
      void normalizeIdKey(String key) {
        final val = normalized[key];
        if (val is String && val.isNotEmpty) {
          normalized[key] = {'_id': val};
        } else if (val == null) {
          normalized[key] = null;
        }
        // if already a Map, keep as-is
      }

      normalizeIdKey('schoolId');
      normalizeIdKey('studId');
      // also normalize applicationId (in case backend returned string)
      normalizeIdKey('applicationId');

      // Ensure _id key exists (some responses use id)
      if (!normalized.containsKey('_id') && normalized.containsKey('id')) {
        normalized['_id'] = normalized['id'];
      }

      print('submitForm normalized: $normalized');

      try {
        final form = Form.fromJson(normalized);
        return Right(form);
      } catch (e, st) {
        print('Form.fromJson failed. normalized: $normalized\nError: $e\n$st');
        return Left(
          APIException(
            message: 'Failed to parse form response',
            statusCode: 500,
          ),
        );
      }
    } catch (e, st) {
      print('submitForm error: $e\n$st');
      // If APIException.from expects an Exception, wrap if necessary:
      if (e is APIException) return Left(e);
      return Left(APIException.from(e));
    }
  }

  @override
  ResultFuture<List<Form>?> trackForm({required String formId}) {
    // TODO: implement trackForm if needed
    throw UnimplementedError();
  }
}
