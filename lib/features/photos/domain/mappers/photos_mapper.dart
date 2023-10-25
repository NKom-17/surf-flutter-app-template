import 'package:flutter_template/api/service/photos/dtos/photos_dto.dart';
import 'package:flutter_template/features/photos/domain/entity/models/photos_model.dart';

/// Extension [PhotosDTO].
extension PhotosDTOToDomain on PhotosDTO {
  /// Converting DTO to model
  PhotosModel toDomain() {
    return PhotosModel(
      photo: urls.regular,
      username: user.username,
      numberOfLikes: likes,
      shadowColor: int.parse('0xFF${color.substring(1)}'),
      blurImage: blurImage,
    );
  }
}
