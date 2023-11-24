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
  Future<List<PhotosModel>> getCachedPhotosDB(int count, [int fromIndex = 0]) async {
    final cachedPhotosDB = await (_db.select(_db.cachedPhotosTable)
          ..limit(
            count,
            offset: fromIndex,
          ))
        .get();

    return cachedPhotosDB.map(CachedPhotosMapper.fromDatabase).toList();
  }

  /// Получение количества фотографий в базе данных
  Future<int> getLengthCachedPhotosDB() async {
    final cachedPhotosDB = await _db.select(_db.cachedPhotosTable).get();
    return cachedPhotosDB.length;
  }

  /// Добавление фотографий в базу данных
  Future<void> insertInCachedPhotosDB(List<PhotosModel> photos) async {
    await _db.batch((batch) {
      batch.insertAll(
        _db.cachedPhotosTable,
        photos.map(CachedPhotosMapper.toDatabase),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  /// Отчистка базы данных
  Future<void> clearCachedPhotosDB() async {
    final cachedPhotosFromDB = await _db.select(_db.cachedPhotosTable).get();

    for (final cachedPhoto in cachedPhotosFromDB) {
      await _db.delete(_db.cachedPhotosTable).delete(cachedPhoto);
    }
  }
}
