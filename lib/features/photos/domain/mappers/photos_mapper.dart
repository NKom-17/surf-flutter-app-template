import 'package:flutter_template/api/service/photos/dtos/photos_dto.dart';
import 'package:flutter_template/features/photos/domain/entity/models/photos_model.dart';

/// Mapper [PhotosDTO].
class PhotosMapper {
  const PhotosMapper._();

  /// Converting [PhotosDTO] to [PhotosModel].
  static PhotosModel fromDTO(PhotosDTO dto) {
    return PhotosModel(
      id: dto.id,
      photo: dto.urls.regular,
      username: dto.user.username,
      numberOfLikes: dto.likes,
      shadowColor: int.parse('0xFF${dto.color.substring(1)}'),
      blurImage: dto.blurImage,
    );
  }
}
