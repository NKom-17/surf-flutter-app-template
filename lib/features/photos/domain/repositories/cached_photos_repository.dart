import 'package:drift/drift.dart';
import 'package:flutter_template/features/photos/databases/database.dart';
import 'package:flutter_template/features/photos/domain/entity/models/photos_model.dart';
import 'package:flutter_template/features/photos/domain/mappers/cached_photos_mapper.dart';

/// Cached photos repository
class CachedPhotosRepository {
  final Database _db;

  /// Create an instance [CachedPhotosRepository].
  const CachedPhotosRepository(this._db);

  /// Получение фотографий из базы данных
  Future<List<PhotosModel>> getCachedPhotosDB(int fromIndex, [int? count]) async {
    final cachedPhotosDB = await _db.select(_db.cachedPhotosTable).get();

    return cachedPhotosDB
        .sublist(fromIndex, count != null ? fromIndex + count : null)
        .map(CachedPhotosMapper.fromDatabase)
        .toList();
  }

  /// Получение количества фотографий в базе данных
  Future<int> getLengthCachedPhotosDB() async {
    final cachedPhotosDB = await _db.select(_db.cachedPhotosTable).get();
    return cachedPhotosDB.length;
  }

  /// Добавление фото в базу данных
  Future<void> insertInCachedPhotosDB(PhotosModel photo) async {
    await _db.into(_db.cachedPhotosTable).insert(
          CachedPhotosMapper.toDatabase(photo),
          mode: InsertMode.insertOrReplace,
        );
  }

  /// Отчистка базы данных
  Future<void> clearCachedPhotosDB() async {
    final cachedPhotosFromDB = await getCachedPhotosDB(0);
    for (final cachedPhoto in cachedPhotosFromDB) {
      await _db.delete(_db.cachedPhotosTable).delete(CachedPhotosMapper.toDatabase(cachedPhoto));
    }
  }
}
