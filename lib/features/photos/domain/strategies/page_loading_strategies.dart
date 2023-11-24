import 'package:flutter/foundation.dart';
import 'package:flutter_template/features/photos/domain/entity/models/photos_model.dart';
import 'package:flutter_template/features/photos/domain/repositories/cached_photos_repository.dart';
import 'package:flutter_template/features/photos/domain/repositories/photos_repository.dart';

/// Interface for page loading strategies.
abstract class LoadingPageStrategy {
  const LoadingPageStrategy._();

  /// Page loading.
  Future<List<PhotosModel>> loadingPage(int page);
}

/// First page loading strategy.
class FirstPageStrategy implements LoadingPageStrategy {
  final PhotosRepository _photosRepository;
  final CachedPhotosRepository _cachedPhotosRepository;

  /// Create an instance [FirstPageStrategy].
  const FirstPageStrategy(this._photosRepository, this._cachedPhotosRepository);

  @override
  Future<List<PhotosModel>> loadingPage(int page) async {
    final response = await _photosRepository.loadingPage(page);

    final cachedPhotosFromDB = await _cachedPhotosRepository.getCachedPhotosDB(10);

    if (listEquals(cachedPhotosFromDB, response)) {
      return cachedPhotosFromDB;
    } else {
      await _cachedPhotosRepository.clearCachedPhotosDB();

      for (final element in response) {
        await _cachedPhotosRepository.insertInCachedPhotosDB(element);
      }

      return response;
    }
  }
}

/// Strategy for loading the next pages.
class NextPageStrategy implements LoadingPageStrategy {
  final PhotosRepository _photosRepository;
  final CachedPhotosRepository _cachedPhotosRepository;

  /// Create an instance [NextPageStrategy].
  const NextPageStrategy(this._photosRepository, this._cachedPhotosRepository);

  @override
  Future<List<PhotosModel>> loadingPage(int page) async {
    const countPhotosOnPage = 10;
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
