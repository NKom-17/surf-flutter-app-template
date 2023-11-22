import 'package:drift/drift.dart';
import 'package:flutter_template/api/service/photos/dtos/photos_dto.dart';
import 'package:flutter_template/features/photos/databases/database.dart';
import 'package:flutter_template/features/photos/domain/entity/models/photos_model.dart';
import 'package:flutter_template/features/photos/domain/mappers/photos_mapper.dart';
import 'package:flutter_template/features/photos/domain/repositories/photos_repository.dart';

/// Cached photos repository
class CachedPhotosRepository implements PhotosRepository {
  final PhotosRepository _photosRepository;
  final Database _db;

  /// Create an instance [CachedPhotosRepository].
  CachedPhotosRepository(this._photosRepository, this._db);

  /// Получение всех фотографий из базы данных
  Future<List<PhotosModel>> getCachedPhotosDB() async {
    final cachedPhotosDB = await _db.select(_db.cachedPhotosTable).get();
    return cachedPhotosDB.map((element) => element.tableToDomain()).toList();
  }

  /// Добавление фото в базу данных
  Future<void> insertInCachedPhotosDB(PhotosModel photo) async {
    await _db.into(_db.cachedPhotosTable).insert(
          photo.toDatabase(),
          mode: InsertMode.insertOrReplace,
        );
  }

  @override
  Future<List<PhotosDTO>> loadingPage(int page) async {
    final response = await _photosRepository.loadingPage(page);
    for (final element in response) {
      await insertInCachedPhotosDB(element.toDomain());
    }

    final photosFromDB = await getCachedPhotosDB();
    return Future.value(photosFromDB.map((element) => element.toDTO()).toList());
  }
}
