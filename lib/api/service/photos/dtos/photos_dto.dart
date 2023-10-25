import 'package:flutter/foundation.dart';
import 'package:flutter_template/api/service/photos/dtos/urls_data_dto.dart';
import 'package:flutter_template/api/service/photos/dtos/user_data_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photos_dto.g.dart';

/// Main DTO model for json processing.
@immutable
@JsonSerializable()
class PhotosDTO {
  /// Links to images
  final UrlsDataDTO urls;

  /// Information about the author of the photo
  final UserDataDTO user;

  /// The number of likes of the photo
  final int likes;

  /// Shadow color of the photo
  final String color;

  /// Blur when uploading a photo
  @JsonKey(name: 'blur_hash')
  final String blurImage;

  /// Create an instance [PhotosDTO].
  const PhotosDTO({
    required this.urls,
    required this.user,
    required this.likes,
    required this.color,
    required this.blurImage,
  });

  /// Deserialization of the received data
  factory PhotosDTO.fromJson(Map<String, dynamic> json) => _$PhotosDTOFromJson(json);
}
