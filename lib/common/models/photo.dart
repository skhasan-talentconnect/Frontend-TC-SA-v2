import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo.freezed.dart';
part 'photo.g.dart';

@freezed
abstract class Photo with _$Photo {
  factory Photo({
 String? url,
 String? publicId,
 @JsonKey(name: "_id")String? id,
 String? uploadedAt,
  }) = _Photo;

  factory Photo.fromJson(Map<String, dynamic> json) =>
      _$PhotoFromJson(json);
}
