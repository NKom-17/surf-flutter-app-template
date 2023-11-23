import 'package:flutter/foundation.dart';
import 'package:flutter_template/features/photos/domain/entity/models/photos_model.dart';
import 'package:flutter_template/features/photos/domain/repositories/cached_photos_repository.dart';
import 'package:flutter_template/features/photos/domain/repositories/photos_repository.dart';

/// A substitute for [PhotosRepository].
class ProxyPhotosRepository implements PhotosRepository {
  final PhotosRepository _photosRepository;
  final CachedPhotosRepository _cachedPhotosRepository;

  /// Create an instance [ProxyPhotosRepository].
  const ProxyPhotosRepository(this._photosRepository, this._cachedPhotosRepository);

  @override
  Future<List<PhotosModel>> loadingPage(int page) async {
    final cachedPhotosFromDB = await _cachedPhotosRepository.getCachedPhotosDB();

    if (page == 1) {
      final response = await _photosRepository.loadingPage(page);

      if (cachedPhotosFromDB.length == 10 && listEquals(cachedPhotosFromDB, response)) {
        return cachedPhotosFromDB;
      } else {
        await _cachedPhotosRepository.clearCachedPhotosDB();

        for (final element in response) {
          await _cachedPhotosRepository.insertInCachedPhotosDB(element);
        }

        final firstPageCachedPhotosDB = await _cachedPhotosRepository.getCachedPhotosDB();
        return firstPageCachedPhotosDB;
      }
    } else {
      if (cachedPhotosFromDB.length >= page * 10) {
        return cachedPhotosFromDB.sublist((page - 1) * 10, page * 10);
      } else {
        final response = await _photosRepository.loadingPage(page);

        for (final element in response) {
          await _cachedPhotosRepository.insertInCachedPhotosDB(element);
        }

        return response;
      }
    }
  }
}
