import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/photos/domain/entity/models/photos_model.dart';
import 'package:flutter_template/features/photos/domain/repository/photos_repository.dart';
import 'package:flutter_template/features/photos/screens/photos_screen/photos_screen.dart';
import 'package:union_state/union_state.dart';

/// Model for [PhotosScreen].
class PhotosScreenModel extends ElementaryModel {
  /// Create an instance [PhotosScreenModel].
  PhotosScreenModel(this._scope) {
    _photosRepository = PhotosRepository(_scope.dio);
  }

  /// Data with a loading state
  final dataState = UnionStateNotifier<List<PhotosModel>>.loading();
  final IAppScope _scope;
  late final PhotosRepository _photosRepository;
  int _page = 1;

  /// Page loading
  Future<void> loadPage() async {
    try {
      dataState.loading(dataState.value.data);

      final response = await _photosRepository.loadingPage(_page);
      response.isNotEmpty ? dataState.content(response) : dataState.failure();
      _page++;
    } on DioError catch (e) {
      dataState.failure(e.error as Exception?, dataState.value.data);
    }
  }
}
