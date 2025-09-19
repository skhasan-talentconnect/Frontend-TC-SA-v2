// features/chatbot/presentation/view_models/chatbot_view_model.dart

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/chatbot/data/data_source/data_source.dart';
import 'package:tc_sa/features/chatbot/data/data_source/data_source_impl.dart';
import 'package:tc_sa/features/chatbot/data/entities/chatbot_question_model.dart';
import 'package:tc_sa/features/chatbot/data/entities/filter_id_model.dart';

class ChatbotViewModel extends ViewStateProvider {
  final ChatbotDataSource _ds = ChatbotDataSourceImpl();
  final _network = getIt<NetworkService>();

  List<ChatbotQuestion> _questions = [];
  List<ChatbotQuestion> get questions => _questions;

  String? _aiResponse;
  String? get aiResponse => _aiResponse;

  List<String> _recommendedSchoolNames = [];
  List<String> get recommendedSchoolNames => _recommendedSchoolNames;

  List<SchoolCardModel> _resolvedSchools = [];
  List<SchoolCardModel> get resolvedSchools => _resolvedSchools;

  bool resolvingCards = false;

  Future<Failure?> loadQuestions() async {
    setViewState(ViewState.busy);
    Failure? failure;
    final res = await _ds.getQuestions();
    res.fold(
      (ex) => failure = APIFailure.fromException(exception: ex),
      (list) => _questions = list,
    );
    setViewState(ViewState.complete);
    notifyListeners();
    return failure;
  }

  // Unified method to apply filters and get both DB and AI results
  Future<Failure?> applyFilters({
    int? questionId,
    Map<String, dynamic>? filters,
  }) async {
    // Clear previous results immediately
    _resolvedSchools = [];
    _recommendedSchoolNames = [];
    _aiResponse = null;
    notifyListeners();

    setViewState(ViewState.busy);

    Failure? overallFailure;

    // Call 1: Get DB results (`useAI=false`)
    final dbResultFuture = questionId != null
        ? _ds.filterByQuestion(questionId, false)
        : _ds.filterWithMultipleCriteria(filters!, false);

    final dbResult = await dbResultFuture;

    dbResult.fold(
      (ex) => overallFailure = ex as Failure?,
      (result) async {
        if (result.schoolIds.isNotEmpty) {
          await _resolveSchoolCards(result.schoolIds);
        }
      },
    );

    // Call 2: Get AI results (`useAI=true`)
    final aiResultFuture = questionId != null
        ? _ds.filterByQuestion(questionId, true)
        : _ds.filterWithMultipleCriteria(filters!, true);

    final aiResult = await aiResultFuture;

    aiResult.fold(
      (ex) => overallFailure ??= ex as Failure?,
      (result) {
        _recommendedSchoolNames = result.recommendedSchools;
        _aiResponse = result.aiResponse;
      },
    );

    setViewState(ViewState.complete);
    notifyListeners();
    return overallFailure;
  }

  Future<void> _resolveSchoolCards(List<String> ids) async {
    if (ids.isEmpty) {
      _resolvedSchools = [];
      return;
    }

    resolvingCards = true;
    notifyListeners();

    try {
      final futures = ids.map((id) => _fetchCardById(id)).toList();
      final results = await Future.wait(futures);

      final cards = <SchoolCardModel>[];
      for (final either in results) {
        either.fold((_) => null, (card) => cards.add(card));
      }

      _resolvedSchools = cards;
    } catch (e) {
      _resolvedSchools = [];
      debugPrint('Error resolving school cards: $e');
    } finally {
      resolvingCards = false;
      notifyListeners();
    }
  }

  Future<Either<APIException, SchoolCardModel>> _fetchCardById(String id) async {
    final request = Request(
      method: RequestMethod.get,
      endpoint: '${Endpoints.adminSchools}/$id',
      isSafeRoute: true,
    );
    try {
      final resp = await _network.request(request);
      final Map<String, dynamic>? payload = (resp.data is Map)
          ? Map<String, dynamic>.from(resp.data as Map)['data'] ??
              Map<String, dynamic>.from(resp.data as Map)
          : null;

      if (payload == null) {
        return Left(APIException(message: 'Invalid response format', statusCode: 400));
      }

      final String schoolId = (payload['_id'] ?? payload['id'] ?? '').toString();
      final String name = (payload['name'] ?? '-') as String;
      final String board = (payload['board'] ?? '-') as String;
      final String feeRange = (payload['feeRange'] ?? '-') as String;
      final String location = [
        (payload['city'] ?? '') as String,
        (payload['state'] ?? '') as String
      ].where((e) => e.isNotEmpty).join(', ');
      final String genderType = (payload['genderType'] ?? '-') as String;
      final String schoolMode = (payload['schoolMode'] ?? '-') as String;
      final List shifts = (payload['shifts'] is List) ? payload['shifts'] as List : const [];
      final int ratings = _safeInt(payload['ratings'] ?? payload['rating'] ?? 0);

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

  void clear() {
    _aiResponse = null;
    _recommendedSchoolNames = [];
    _resolvedSchools = [];
    notifyListeners();
  }
}