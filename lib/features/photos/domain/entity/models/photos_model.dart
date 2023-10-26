import 'package:flutter/foundation.dart';

/// Model for photos.
@immutable
class PhotosModel {
  /// Create an instance [PhotosModel].
  const PhotosModel({
    required this.photo,
    required this.username,
    required this.numberOfLikes,
    required this.shadowColor,
    required this.blurImage,
  });

  /// Image
  final String photo;

  /// The author of the photo
  final String username;

  /// The number of likes of the photo
  final int numberOfLikes;

  /// Shadow color of the photo
  final int shadowColor;

  /// Blur when uploading a photo
  final String blurImage;
}
