import 'package:flutter_template/features/photos/databases/database.dart';
import 'package:flutter_template/features/photos/domain/entity/models/photos_model.dart';

/// Mapper [CachedPhotosTableData].
class CachedPhotosMapper {
  const CachedPhotosMapper._();

  /// Converting [PhotosModel] to [CachedPhotosTableData].
  static CachedPhotosTableData toDatabase(PhotosModel model) {
    return CachedPhotosTableData(
      id: model.id,
      username: model.username,
      photo: model.photo,
      numberOfLikes: model.numberOfLikes,
      shadowColor: model.shadowColor,
      blurImage: model.blurImage,
    );
  }

  /// Converting [CachedPhotosTableData] to [PhotosModel].
  static PhotosModel fromDatabase(CachedPhotosTableData tableData) {
    return PhotosModel(
      id: tableData.id,
      username: tableData.username,
      photo: tableData.photo,
      numberOfLikes: tableData.numberOfLikes,
      shadowColor: tableData.shadowColor,
      blurImage: tableData.blurImage,
    );
  }
}
