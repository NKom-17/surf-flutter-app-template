import 'package:flutter/foundation.dart';
import 'package:flutter_template/features/photos/domain/entity/models/photos_model.dart';
import 'package:flutter_template/features/photos/domain/repositories/cached_photos_repository.dart';
import 'package:flutter_template/features/photos/domain/repositories/photos_repository.dart';

/// Interface for page loading strategies.
abstract class ILoadingPageStrategy {
  /// Create an instance [ILoadingPageStrategy].
  const ILoadingPageStrategy();

  /// Page loading.
  Future<List<PhotosModel>> loadingPage(int page);
}

/// First page loading strategy.
class FirstPageStrategy implements ILoadingPageStrategy {
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
      await _cachedPhotosRepository.insertInCachedPhotosDB(response);

      return response;
    }
  }
}

/// Strategy for loading the next pages.
class NextPageStrategy implements ILoadingPageStrategy {
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
      await _cachedPhotosRepository.insertInCachedPhotosDB(response);

      return response;
    }
  }
}

/// Page loader.
class PageLoader {
  final PhotosRepository _photosRepository;
  final CachedPhotosRepository _cachedPhotosRepository;

  /// Create an instance [PageLoader].
  const PageLoader(
    this._photosRepository,
    this._cachedPhotosRepository,
  );

  /// Selecting a strategy.
  Future<List<PhotosModel>> loadingPage(int page) {
    if (page == 1) {
      final strategy = FirstPageStrategy(_photosRepository, _cachedPhotosRepository);
      return strategy.loadingPage(page);
    } else {
      final strategy = NextPageStrategy(_photosRepository, _cachedPhotosRepository);
      return strategy.loadingPage(page);
    }
  }
}
