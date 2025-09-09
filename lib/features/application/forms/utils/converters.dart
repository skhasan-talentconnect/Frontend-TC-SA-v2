import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

class FormStatusConverter implements JsonConverter<FormStatus, String> {
  const FormStatusConverter();

  @override
  FormStatus fromJson(String json) {
    return FormStatusExt.fromApiValue(json);
  }

  @override
  String toJson(FormStatus object) {
    return object.label;
  }
}
