import 'package:flutter_template/features/photos/domain/entity/models/photos_model.dart';
import 'package:flutter_template/features/photos/domain/repositories/cached_photos_repository.dart';
import 'package:flutter_template/features/photos/domain/repositories/photos_repository.dart';
import 'package:flutter_template/features/photos/domain/strategies/page_loading_strategies.dart';

/// A substitute for [PhotosRepository].
class ProxyPhotosRepository implements PhotosRepository {
  final PhotosRepository _photosRepository;
  final CachedPhotosRepository _cachedPhotosRepository;

  /// Create an instance [ProxyPhotosRepository].
  const ProxyPhotosRepository(this._photosRepository, this._cachedPhotosRepository);

  @override
  Future<List<PhotosModel>> loadingPage(int page) async {
    final pageLoader = PageLoader(_photosRepository, _cachedPhotosRepository);
    return pageLoader.loadingPage(page);
  }
}
