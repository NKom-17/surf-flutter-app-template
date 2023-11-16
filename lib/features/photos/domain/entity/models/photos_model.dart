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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is PhotosModel &&
        other.runtimeType == runtimeType &&
        other.photo == photo &&
        other.username == username &&
        other.numberOfLikes == numberOfLikes &&
        other.shadowColor == shadowColor &&
        other.blurImage == blurImage;
  }

  @override
  int get hashCode => Object.hash(photo, username, numberOfLikes, shadowColor, blurImage);
}
