import 'package:flutter_template/api/service/photos/dtos/photos_dto.dart';
import 'package:flutter_template/api/service/photos/dtos/urls_data_dto.dart';
import 'package:flutter_template/api/service/photos/dtos/user_data_dto.dart';
import 'package:flutter_template/features/photos/databases/database.dart';
import 'package:flutter_template/features/photos/domain/entity/models/photos_model.dart';

/// Extension [PhotosModel].
extension PhotosModelToDTO on PhotosModel {
  /// Converting model to DTO.
  PhotosDTO toDTO() {
    return PhotosDTO(
      id: id,
      urls: UrlsDataDTO(photo),
      user: UserDataDTO(username),
      likes: numberOfLikes,
      color: '#${shadowColor.toString().substring(5)}',
      blurImage: blurImage,
    );
  }
}

/// Extension [PhotosModel].
extension PhotosModelToDatabase on PhotosModel {
  /// Converting PhotosModel to CachedPhotosTableData.
  CachedPhotosTableData toDatabase() {
    return CachedPhotosTableData(
      id: id,
      username: username,
      photo: photo,
      numberOfLikes: numberOfLikes,
      shadowColor: shadowColor,
      blurImage: blurImage,
    );
  }
}

/// Extension [CachedPhotosTableData].
extension CachedPhotosTableDataToDomain on CachedPhotosTableData {
  /// Converting CachedPhotosTableData to PhotosModel.
  PhotosModel tableToDomain() {
    return PhotosModel(
      id: id,
      username: username,
      photo: photo,
      numberOfLikes: numberOfLikes,
      shadowColor: shadowColor,
      blurImage: blurImage,
    );
  }
}
