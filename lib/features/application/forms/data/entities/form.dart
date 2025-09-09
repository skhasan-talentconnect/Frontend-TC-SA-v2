import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/features/application/forms/index.dart';
import 'package:tc_sa/features/detailPages/overview/data/entities/overview_model.dart';

part 'form.freezed.dart';
part 'form.g.dart';

@freezed
abstract class Form with _$Form {
  const factory Form({
    @JsonKey(name: '_id') String? sId,
    @JsonKey(name: 'schoolId') SchoolModel? school,
    @JsonKey(name: 'studId') User? user,
    //dynamic? applicationForm,
    @FormStatusConverter() FormStatus? status,
    @JsonKey(name: '__v') int? iV,
    String? createdAt,
    String? updatedAt,
  }) = _Form;

  factory Form.fromJson(Map<String, dynamic> json) => _$FormFromJson(json);
}
