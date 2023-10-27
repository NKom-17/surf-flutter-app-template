import 'dart:io';

import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/photos/domain/entity/models/photos_model.dart';
import 'package:flutter_template/features/photos/domain/mappers/photos_mapper.dart';
import 'package:flutter_template/features/photos/domain/repository/photos_repository.dart';
import 'package:flutter_template/features/photos/screens/photos_screen/photos_screen.dart';
import 'package:union_state/union_state.dart';

/// Statuses for data states.
enum DataStateStatus {
  /// Status of data initialization.
  initial,

  /// Status of data loading.
  loading,

  /// Status of data failure.
  failure,

  /// Status of data success.
  success,
}

/// Model for [PhotosScreen].
class PhotosScreenModel extends ElementaryModel {
  /// Create an instance [PhotosScreenModel].
  PhotosScreenModel(this._scope) {
    _photosRepository = PhotosRepository(_scope.dio);
  }

  /// Data with a loading state
  final dataState = UnionStateNotifier<List<PhotosModel>>.loading();

  /// Current status of the data state
  DataStateStatus dataStateStatus = DataStateStatus.initial;

  final IAppScope _scope;
  late final PhotosRepository _photosRepository;
  final _listPhotos = <PhotosModel>[];
  int _page = 1;
  bool _contentIsOver = false;

  /// Page loading
  Future<void> loadPage() async {
    if (_contentIsOver) return;
    try {
      dataStateStatus = DataStateStatus.loading;
      dataState.loading(dataState.value.data);

      final response = await _photosRepository.loadingPage(_page);
      _listPhotos.addAll(
        response.map((element) => element.toDomain()),
      );
      dataState.content(_listPhotos);

      response.isNotEmpty ? _page++ : _contentIsOver = true;
      dataStateStatus = DataStateStatus.success;
    } on DioError catch (e) {
      dataStateStatus = DataStateStatus.failure;
      Exception? handledException;
      if (e.error is SocketException) handledException = e.error as Exception?;
      dataState.failure(handledException ?? e, dataState.value.data);
      rethrow;
    }
  }
}

/// Extension for getting the current status of the data state.
extension DataStateStatusX on DataStateStatus {
  /// The current status of the data is loading.
  bool get isLoading => this == DataStateStatus.loading;
}
