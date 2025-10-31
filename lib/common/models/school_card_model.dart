import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tc_sa/common/index.dart';

part 'school_card_model.freezed.dart';
part 'school_card_model.g.dart';

@freezed
abstract class SchoolCardModel with _$SchoolCardModel {
  factory SchoolCardModel({
    String? schoolId,
    int? ratings,
    String? name,
    String? feeRange,
    String? area,
    String? location,
    Photo? coverImage,
    String? board,
    String? genderType,
    double? score,
    double? latitude,
    double? longitude,
    List<String>? shifts,
    List<String>? amenities,
    String? schoolMode,
  }) = _SchoolCardModel;

  factory SchoolCardModel.fromJson(Map<String, dynamic> json) =>
      _$SchoolCardModelFromJson(json);
}
