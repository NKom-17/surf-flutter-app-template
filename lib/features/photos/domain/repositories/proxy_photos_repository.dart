import 'dart:async';
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:flutter_template/config/app_config.dart';
import 'package:flutter_template/config/environment/build_types.dart';
import 'package:flutter_template/config/environment/environment.dart';
import 'package:flutter_template/config/urls.dart';
import 'package:flutter_template/features/photos/domain/entity/models/photos_model.dart';
import 'package:flutter_template/features/photos/domain/repositories/cached_photos_repository.dart';
import 'package:flutter_template/features/photos/domain/repositories/photos_repository.dart';
import 'package:flutter_template/features/photos/domain/strategies/page_loading_strategies.dart';

/// A substitute for [PhotosRepository].
class ProxyPhotosRepository implements PhotosRepository {
  final PhotosRepository _photosRepository;
  final CachedPhotosRepository _cachedPhotosRepository;

  late final Isolate _isolate;
  late final ReceivePort _receivePort;
  late SendPort _sendPortToIsolate;
  Completer<List<PhotosModel>>? _completer;
  final _isolateReady = Completer<void>();

  /// Create an instance [ProxyPhotosRepository].
  ProxyPhotosRepository(this._photosRepository, this._cachedPhotosRepository) {
    _initIsolate();
  }

  /// Is the isolate ready to transmit messages.
  Future<void> get isReady => _isolateReady.future;

  Future<void> _initIsolate() async {
    _receivePort = ReceivePort();
    final rootIsolateToken = RootIsolateToken.instance!;

    _isolate = await Isolate.spawn<_IsolateData>(
      _entryPoint,
      _IsolateData(
        token: rootIsolateToken,
        sendPortToMain: _receivePort.sendPort,
      ),
    );

    _receivePort.listen((message) {
      if (message is SendPort) {
        _sendPortToIsolate = message;
        _isolateReady.complete();
        return;
      }
      if (message is List<PhotosModel>) {
        _completer?.complete(message);
        _completer = null;
        return;
      }
      throw UnimplementedError('Undefined behavior for message: $message');
    });
  }

  /// Dispose of Isolate.
  void disposeIsolate() {
    _receivePort.close();
    _isolate.kill();
  }

  @override
  Future<List<PhotosModel>> loadingPage(int page) async {
    _sendPortToIsolate.send(_IsolateMessage(_photosRepository, _cachedPhotosRepository, page));

    _completer = Completer<List<PhotosModel>>();
    return _completer!.future;
  }
}

void _entryPoint(_IsolateData isolateData) {
  late PhotosRepository photosRepository;
  late CachedPhotosRepository cachedPhotosRepository;
  late int page;

  final receivePort = ReceivePort()
    ..listen((message) async {
      if (message is _IsolateMessage) {
        photosRepository = message.photosRepository;
        cachedPhotosRepository = message.cachedPhotosRepository;
        page = message.page;
      }

      Environment.init(
        buildType: BuildType.debug,
        config: AppConfig(
          url: Url.testUrl,
          clientIdOfQueryPhotos: Url.clientIdOfQueryPhotos,
        ),
      );
      BackgroundIsolateBinaryMessenger.ensureInitialized(isolateData.token);

      final ILoadingPageStrategy strategy;
      if (page == 1) {
        strategy = FirstPageStrategy(photosRepository, cachedPhotosRepository);
      } else {
        strategy = NextPageStrategy(photosRepository, cachedPhotosRepository);
      }

      final answer = await strategy.loadingPage(page);
      isolateData.sendPortToMain.send(answer);
    });

  isolateData.sendPortToMain.send(receivePort.sendPort);
}

class _IsolateData {
  final RootIsolateToken token;
  final SendPort sendPortToMain;

  const _IsolateData({required this.token, required this.sendPortToMain});
}

class _IsolateMessage {
  final PhotosRepository photosRepository;
  final CachedPhotosRepository cachedPhotosRepository;
  final int page;

  const _IsolateMessage(this.photosRepository, this.cachedPhotosRepository, this.page);
}
