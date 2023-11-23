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
    const countPhotosOnPage = 10;
    if (page == 1) {
      final response = await _photosRepository.loadingPage(page);

      final cachedPhotosFromDB = await _cachedPhotosRepository.getCachedPhotosDB(countPhotosOnPage);

      if (listEquals(cachedPhotosFromDB, response)) {
        return cachedPhotosFromDB;
      } else {
        await _cachedPhotosRepository.clearCachedPhotosDB();

        for (final element in response) {
          await _cachedPhotosRepository.insertInCachedPhotosDB(element);
        }

        return response;
      }
    } else {
      final countPhotosInDB = await _cachedPhotosRepository.getLengthCachedPhotosDB();
      if (countPhotosInDB >= page * countPhotosOnPage) {
        return _cachedPhotosRepository.getCachedPhotosDB(
          countPhotosOnPage,
          (page - 1) * countPhotosOnPage,
        );
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
