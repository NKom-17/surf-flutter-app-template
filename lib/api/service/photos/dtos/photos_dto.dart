import 'package:json_annotation/json_annotation.dart';

part 'photos_dto.g.dart';

/// DTO model for json processing.
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
  PhotosDTO({
    required this.urls,
    required this.user,
    required this.likes,
    required this.color,
    required this.blurImage,
  });

  /// Deserialization of the received data
  factory PhotosDTO.fromJson(Map<String, dynamic> json) =>
      _$PhotosDTOFromJson(json);
}

/// DTO model of image links.
@JsonSerializable()
class UrlsDataDTO {
  /// Image
  final String regular;

  /// Create an instance [UrlsDataDTO].
  UrlsDataDTO(this.regular);

  /// Deserialization of the received data
  factory UrlsDataDTO.fromJson(Map<String, dynamic> json) =>
      _$UrlsDataDTOFromJson(json);
}

/// The DTO model of information about the author
@JsonSerializable()
class UserDataDTO {
  /// The author of the photo
  final String username;

  /// Create an instance [UserDataDTO].
  UserDataDTO(this.username);

  /// Deserialization of the received data
  factory UserDataDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDataDTOFromJson(json);
}
