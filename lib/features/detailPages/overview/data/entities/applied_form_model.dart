import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tc_sa/features/application/forms/index.dart';

part 'applied_form_model.freezed.dart';
part 'applied_form_model.g.dart';

@freezed
abstract class AppliedFormModel with _$AppliedFormModel {
  const factory AppliedFormModel({
    String? formId,
    bool? isApplied,
    @FormStatusConverter() FormStatus? status,
  }) = _AppliedFormModel;

  factory AppliedFormModel.fromJson(Map<String, dynamic> json) =>
      _$AppliedFormModelFromJson(json);
}
