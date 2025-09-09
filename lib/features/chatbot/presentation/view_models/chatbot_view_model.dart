// features/chatbot/presentation/view_models/chatbot_view_model.dart
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tc_sa/common/index.dart'; // SchoolCardModel, Failure, APIFailure, ViewStateProvider
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/chatbot/data/data_source/data_source.dart';
import 'package:tc_sa/features/chatbot/data/data_source/data_source_impl.dart';
import 'package:tc_sa/features/chatbot/data/entities/chatbot_question_model.dart';
import 'package:tc_sa/features/chatbot/data/entities/filter_id_model.dart';   // getIt, NetworkService, Endpoints, Request, RequestMethod

class ChatbotViewModel extends ViewStateProvider {
  final ChatbotDataSource _ds = ChatbotDataSourceImpl();
  final _network = getIt<NetworkService>();

  // questions
  List<ChatbotQuestion> _questions = [];
  List<ChatbotQuestion> get questions => _questions;
  set questions(List<ChatbotQuestion> value) {
    _questions = value;
    notifyListeners();
  }

  // ids from filter
  FilterIdsResult? _idsResult;
  FilterIdsResult? get idsResult => _idsResult;

  // resolved cards
  List<SchoolCardModel> _resolvedSchools = [];
  List<SchoolCardModel> get resolvedSchools => _resolvedSchools;
  set resolvedSchools(List<SchoolCardModel> v) {
    _resolvedSchools = v;
    notifyListeners();
  }

  bool resolvingCards = false;

  // ---------- load questions ----------
  Future<Failure?> loadQuestions() async {
    setViewState(ViewState.busy);
    Failure? failure;
    final res = await _ds.getQuestions();
    res.fold(
      (ex) => failure = APIFailure.fromException(exception: ex),
      (list) => questions = list,
    );
    setViewState(ViewState.complete);
    return failure;
  }

  // ---------- single question path ----------
  Future<Failure?> applyFilterByQuestion(int questionId) async {
    setViewState(ViewState.busy);
    Failure? failure;
    final res = await _ds.filterByQuestion(questionId);
    res.fold(
      (ex) => failure = APIFailure.fromException(exception: ex),
      (result) => _idsResult = result,
    );
    setViewState(ViewState.complete);
    return failure;
  }

  // ---------- multiple criteria path ----------
  Future<Failure?> applyFilterWithMultipleCriteria(Map<String, dynamic> filters) async {
    setViewState(ViewState.busy);
    Failure? failure;
    final res = await _ds.filterWithMultipleCriteria(filters);
    res.fold(
      (ex) => failure = APIFailure.fromException(exception: ex),
      (result) => _idsResult = result,
    );
    setViewState(ViewState.complete);
    return failure;
  }

  // ---------- resolve ids -> cards via detail endpoint ----------
 // features/chatbot/presentation/view_models/chatbot_view_model.dart
// (only showing the mapper + resolve method bits)

Future<Failure?> resolveSchoolCardsFromIds() async {
  final ids = _idsResult?.schoolIds ?? const <String>[];
  if (ids.isEmpty) {
    resolvedSchools = [];
    return null;
  }

  resolvingCards = true;
  notifyListeners();

  try {
    final futures = ids.map(_fetchCardById).toList();
    final results = await Future.wait(futures);

    final cards = <SchoolCardModel>[];
    for (final either in results) {
      either.fold(
        (_) {},
        (card) => cards.add(card),
      );
    }
    resolvedSchools = cards;
    return null;
  } catch (_) {
    return APIFailure(message: 'Failed to resolve schools', statusCode: 404);
  } finally {
    resolvingCards = false;
    notifyListeners();
  }
}

Future<Either<APIException, SchoolCardModel>> _fetchCardById(String id) async {
  final request = Request(
    method: RequestMethod.get,
    endpoint: '${Endpoints.adminSchools}/$id', // e.g. /api/admin/schools/:id
    isSafeRoute: true,
  );

  try {
    final resp = await _network.request(request);

    // Your backend may either return { data: {...} } or just {...}
    final dataRaw = resp.data;
    final payload = (dataRaw is Map && dataRaw['data'] is Map)
        ? Map<String, dynamic>.from(dataRaw['data'])
        : (dataRaw is Map ? Map<String, dynamic>.from(dataRaw) : <String, dynamic>{});

    // Map backend fields -> SchoolCardModel fields
    final String schoolId   = (payload['_id'] ?? payload['id'] ?? '').toString();
    final String name       = (payload['name'] ?? '-') as String;
    final String board      = (payload['board'] ?? '-') as String;
    final String feeRange   = (payload['feeRange'] ?? '-') as String;
    final String city       = (payload['city'] ?? '') as String;
    final String state      = (payload['state'] ?? '') as String;
    final String location   = [city, state].where((e) => e.isNotEmpty).join(', ');
    final String genderType = (payload['genderType'] ?? '-') as String;
    final String schoolMode = (payload['schoolMode'] ?? '-') as String;
    final List shifts       = (payload['shifts'] is List) ? payload['shifts'] as List : const [];
    final int ratings       = _safeInt(payload['ratings'] ?? payload['rating'] ?? 0);

    final card = SchoolCardModel(
      schoolId: schoolId,
      name: name,
      board: board,
      feeRange: feeRange,
      location: location,
      genderType: genderType,
      schoolMode: schoolMode,
      shifts: shifts.map((e) => e.toString()).toList(),
      ratings: ratings,
    );

    return Right(card);
  } catch (e) {
    return Left(APIException.from(e));
  }
}

int _safeInt(dynamic v) {
  if (v is int) return v;
  if (v is double) return v.round();
  if (v is String) {
    final n = int.tryParse(v);
    if (n != null) return n;
    final d = double.tryParse(v);
    if (d != null) return d.round();
  }
  return 0;
}


  // ---------- helper: fetch 1 card by id ----------

  void clear() {
    _idsResult = null;
    resolvedSchools = [];
  }
}
