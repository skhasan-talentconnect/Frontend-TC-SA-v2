import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/application/forms/index.dart';

class FormDataSourceImpl implements FormDataSource {
  final _appStateProvider = getIt<AppStateProvider>();
  final _networkService = getIt<NetworkService>();

  @override
  ResultFuture<Form?> getFormById({required String formId}) async {
    Request request = Request(
      method: RequestMethod.get,
      endpoint: '${Endpoints.form}/$formId',
      isSafeRoute: true,
    );

    try {
      final result = await _networkService.request(request);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final form = Form.fromJson(response['data']);

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
      final response = result.data['data'] as List<dynamic>;

      if (response.isNotEmpty) {
        final forms =
            response
                .map((form) => Form.fromJson(form as Map<String, dynamic>))
                .toList();

        return Right(forms);
      }
    } catch (e, s) {
      print('$e\n$s');
      return Left(APIException.from(e));
    }

    return Right([]);
  }

  @override
  ResultFuture<Form?> submitForm({
    required String applicationId,
    required String schoolId,
  }) async {
    Request request = Request(
      method: RequestMethod.post,
      endpoint:
          '${Endpoints.form}/$schoolId/${_appStateProvider.user?.sId}/688896ca314869921c8720c3',
    );

    try {
      final result = await _networkService.request(request);
      final response = result.data as Map<String, dynamic>;

      if (response.isNotEmpty) {
        final form = Form.fromJson(response);

        return Right(form);
      }
    } catch (e) {
      return Left(APIException.from(e));
    }

    return Right(null);
  }

  @override
  ResultFuture<List<Form>?> trackForm({required String formId}) {
    // TODO: implement trackForm
    throw UnimplementedError();
  }
}
