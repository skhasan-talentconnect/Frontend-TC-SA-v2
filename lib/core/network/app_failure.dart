import 'package:tc_sa/core/network/exceptions.dart' show APIException;

abstract class Failure {
  Failure({required this.message, required this.statusCode});

  String? message;
  int? statusCode;
}

class APIFailure extends Failure {
  APIFailure({required super.message, required super.statusCode});

  factory APIFailure.fromException({required APIException exception}) =>
      APIFailure(message: exception.message, statusCode: exception.statusCode);
}
