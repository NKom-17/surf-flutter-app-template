import 'package:drift/drift.dart';
import 'package:flutter_template/api/service/photos/dtos/photos_dto.dart';
import 'package:flutter_template/features/photos/databases/database.dart';
import 'package:flutter_template/features/photos/domain/entity/models/photos_model.dart';
import 'package:flutter_template/features/photos/domain/mappers/cached_photos_mapper.dart';
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

  /// Отчистка базы данных
  Future<void> clearCachedPhotosDB() async {
    final cachedPhotosFromDB = await getCachedPhotosDB();
    for (final cachedPhoto in cachedPhotosFromDB) {
      await _db.delete(_db.cachedPhotosTable).delete(cachedPhoto.toDatabase());
    }
  }

  @override
  Future<List<PhotosDTO>> loadingPage(int page) async {
    final cachedPhotosFromDB = await getCachedPhotosDB();

    if (page == 1) {
      final response = await _photosRepository
          .loadingPage(page)
          .then((value) => value.map((element) => element.toDomain()).toList());

      final firstPageFromDB =
          cachedPhotosFromDB.where(response.contains).map((element) => element.toDTO()).toList();

      if (firstPageFromDB.length == 10) {
        return Future.value(firstPageFromDB);
      } else {
        await clearCachedPhotosDB();

        for (final element in response) {
          await insertInCachedPhotosDB(element);
        }

        final firstPageCachedPhotosDB = await getCachedPhotosDB()
            .then((value) => value.map((element) => element.toDTO()).toList());
        return Future.value(firstPageCachedPhotosDB);
      }
    } else {
      if (cachedPhotosFromDB.length >= page * 10) {
        return Future.value(
          cachedPhotosFromDB
              .map((element) => element.toDTO())
              .toList()
              .sublist((page - 1) * 10, page * 10),
        );
      } else {
        final response = await _photosRepository
            .loadingPage(page)
            .then((value) => value.map((element) => element.toDomain()).toList());

        for (final element in response) {
          await insertInCachedPhotosDB(element);
        }

        final photosFromDB = await getCachedPhotosDB();

        final newPagePhotosDTOFromDB = [
          ...photosFromDB.where(response.contains).map((element) => element.toDTO())
        ];

        return Future.value(newPagePhotosDTOFromDB);
      }
    }
  }
}
