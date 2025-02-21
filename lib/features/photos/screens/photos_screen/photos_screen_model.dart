import 'dart:io';

import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_template/features/photos/domain/entity/models/photos_model.dart';
import 'package:flutter_template/features/photos/domain/repositories/proxy_photos_repository.dart';
import 'package:flutter_template/features/photos/screens/photos_screen/photos_screen.dart';
import 'package:union_state/union_state.dart';

/// Model for [PhotosScreen].
class PhotosScreenModel extends ElementaryModel {
  /// Create an instance [PhotosScreenModel].
  PhotosScreenModel(this._proxyPhotosRepository);

  /// Data with a loading state
  final dataState = UnionStateNotifier<List<PhotosModel>>.loading();
  final ProxyPhotosRepository _proxyPhotosRepository;

  final _listPhotos = <PhotosModel>[];
  int _page = 1;

  /// Signals that content is over
  @visibleForTesting
  bool contentIsOver = false;

  /// Page loading
  Future<void> loadPage() async {
    if (contentIsOver) return;
    try {
      dataState.loading(dataState.value.data);

      final response = await _proxyPhotosRepository.loadingPage(_page);
      _listPhotos.addAll(response);

      dataState.content(_listPhotos);

      response.isNotEmpty ? _page++ : contentIsOver = true;
    } on DioError catch (e) {
      Exception? handledException;
      if (e.error is SocketException) handledException = e.error as Exception?;
      dataState.failure(handledException ?? e, dataState.value.data);
      rethrow;
    }
  }
}

/// Extension for getting the current status of the data state.
extension StatusOfUnionState on UnionState<List<PhotosModel>> {
  /// The current status of the data is loading.
  bool get isLoading => this is UnionStateLoading;

  /// The current status of the data is content.
  bool get isContent => this is UnionStateContent;

  /// The current status of the data is failure.
  bool get isFailure => this is UnionStateFailure;
}
