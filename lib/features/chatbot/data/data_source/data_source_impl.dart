import 'package:dartz/dartz.dart';
import 'package:tc_sa/core/index.dart';
import 'package:tc_sa/features/chatbot/data/data_source/data_source.dart';
import 'package:tc_sa/features/chatbot/data/entities/chatbot_question_model.dart';
import 'package:tc_sa/features/chatbot/data/entities/filter_id_model.dart';

class ChatbotDataSourceImpl implements ChatbotDataSource {
  final _networkService = getIt<NetworkService>();
  String get _base => Endpoints.chatbotBase;

  @override
  ResultFuture<List<ChatbotQuestion>> getQuestions() async {
    final request = Request(
      method: RequestMethod.get,
      endpoint: '$_base/questions',
    );
    try {
      final result = await _networkService.request(request);
      final list = result.data?['data'] as List<dynamic>? ?? const [];
      return Right(list
          .map((e) => ChatbotQuestion.fromJson(e as Map<String, dynamic>))
          .toList());
    } catch (e) {
      return Left(APIException.from(e));
    }
  }

  @override
  ResultFuture<List<ChatbotQuestion>> getQuestionsByCategory(String category) async {
    final request = Request(
      method: RequestMethod.get,
      endpoint: '$_base/questions/category/$category',
    );
    try {
      final result = await _networkService.request(request);
      final list = result.data?['data'] as List<dynamic>? ?? const [];
      return Right(list
          .map((e) => ChatbotQuestion.fromJson(e as Map<String, dynamic>))
          .toList());
    } catch (e) {
      return Left(APIException.from(e));
    }
  }

  // Updated method to include the `useAI` flag.
  @override
  ResultFuture<FilterIdsResult> filterByQuestion({required int questionId,required bool useAI, bool? useArea, bool? useCity}) async {
    final area=(useArea ?? false) ? "&area=${getIt<AppStateProvider>().user?.area}" : '';
     final city=(useCity ?? false) ? "&city=${getIt<AppStateProvider>().user?.city}" : '';
   final requestUrl= '$_base/filter/question/$questionId?useAI=$useAI$area$city';
    final request = Request(
      method: RequestMethod.get,
      endpoint: requestUrl,
    );
    try {
      final result = await _networkService.request(request);
      return Right(FilterIdsResult.fromJson(result.data as Map<String, dynamic>));
    } catch (e) {
      return Left(APIException.from(e));
    }
  }

  @override
  ResultFuture<FilterIdsResult> filterWithMultipleCriteria(Map<String, dynamic> filters, bool useAI) async {
    final request = Request(
      method: RequestMethod.post,
      endpoint: '$_base/filter?useAI=$useAI',
      body: filters,
    );
    try {
      final result = await _networkService.request(request);
      return Right(FilterIdsResult.fromJson(result.data as Map<String, dynamic>));
    } catch (e) {
      return Left(APIException.from(e));
    }
  }
}