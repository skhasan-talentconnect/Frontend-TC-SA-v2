import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tc_sa/common/index.dart';
import 'package:tc_sa/features/application/forms/index.dart';

import 'package:tc_sa/features/application/forms/presentation/widgets/date_time_converter.dart';
import 'package:tc_sa/features/detailPages/overview/data/entities/overview_model.dart';

part 'form.freezed.dart';
part 'form.g.dart';

@freezed
abstract class Form with _$Form {
  const factory Form({
    @JsonKey(name: '_id') String? sId,
    @JsonKey(name: 'schoolId') SchoolModel? school,
    @JsonKey(name: 'studId') User? user,
@JsonKey(name: 'interviewNote') String? interviewNote,
    @FormStatusConverter() FormStatus? status,
    @JsonKey(name: '__v') int? iV,
  @DateTimeConverter() DateTime? createdAt,
    @DateTimeConverter() DateTime? updatedAt,
  }) = _Form;

  factory Form.fromJson(Map<String, dynamic> json) => _$FormFromJson(json);
}
