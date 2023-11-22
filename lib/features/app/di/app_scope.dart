import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/config/environment/environment.dart';
import 'package:flutter_template/features/common/service/theme/theme_service.dart';
import 'package:flutter_template/features/common/service/theme/theme_service_impl.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:flutter_template/features/photos/databases/database.dart';
import 'package:flutter_template/features/photos/domain/repositories/cached_photos_repository.dart';
import 'package:flutter_template/features/photos/domain/repositories/photos_repository.dart';
import 'package:flutter_template/persistence/storage/theme_storage/theme_storage.dart';
import 'package:flutter_template/persistence/storage/theme_storage/theme_storage_impl.dart';
import 'package:flutter_template/util/default_error_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Scope of dependencies which need through all app's life.
class AppScope implements IAppScope {
  static const _themeByDefault = ThemeMode.system;

  final SharedPreferences _sharedPreferences;

  late final Dio _dio;
  late final ErrorHandler _errorHandler;
  late final AppRouter _router;
  late final IThemeService _themeService;
  late final PhotosRepository _photosRepository;
  late final Database _db;
  late final CachedPhotosRepository _cachedPhotosRepository;

  @override
  late VoidCallback applicationRebuilder;

  @override
  Dio get dio => _dio;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  AppRouter get router => _router;

  @override
  IThemeService get themeService => _themeService;

  @override
  SharedPreferences get sharedPreferences => _sharedPreferences;

  @override
  PhotosRepository get photosRepository => _photosRepository;

  @override
  Database get db => _db;

  @override
  CachedPhotosRepository get cachedPhotosRepository => _cachedPhotosRepository;

  late IThemeModeStorage _themeModeStorage;

  /// Create an instance [AppScope].
  AppScope(this._sharedPreferences) {
    /// List interceptor. Fill in as needed.
    final additionalInterceptors = <Interceptor>[];

    _dio = _initDio(additionalInterceptors);
    _photosRepository = PhotosRepository(_dio);
    _errorHandler = DefaultErrorHandler();
    _router = AppRouter.instance();
    _themeModeStorage = ThemeModeStorageImpl(_sharedPreferences);
    _db = Database();
    _cachedPhotosRepository = CachedPhotosRepository(_photosRepository, _db);
  }

  @override
  Future<void> initTheme() async {
    final theme = await ThemeModeStorageImpl(_sharedPreferences).getThemeMode() ?? _themeByDefault;
    _themeService = ThemeServiceImpl(theme);
    _themeService.addListener(_onThemeModeChanged);
  }

  Dio _initDio(Iterable<Interceptor> additionalInterceptors) {
    const timeout = Duration(seconds: 30);

    final dio = Dio();

    dio.options
      ..baseUrl = Environment.instance().config.url
      ..connectTimeout = timeout
      ..receiveTimeout = timeout
      ..sendTimeout = timeout;

    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
      final proxyUrl = Environment.instance().config.proxyUrl;
      if (proxyUrl != null && proxyUrl.isNotEmpty) {
        client
          ..findProxy = (uri) {
            return 'PROXY $proxyUrl';
          }
          ..badCertificateCallback = (_, __, ___) {
            return true;
          };
      }

      return client;
    };

    dio.interceptors.addAll(additionalInterceptors);

    if (Environment.instance().isDebug) {
      dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    }

    return dio;
  }

  Future<void> _onThemeModeChanged() async {
    await _themeModeStorage.saveThemeMode(mode: _themeService.currentThemeMode);
  }
}

/// App dependencies.
abstract class IAppScope {
  /// Http client.
  Dio get dio;

  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Callback to rebuild the whole application.
  VoidCallback get applicationRebuilder;

  /// Class that coordinates navigation for the whole app.
  AppRouter get router;

  /// A service that stores and retrieves app theme mode.
  IThemeService get themeService;

  /// Init theme service with theme from storage or default value.
  Future<void> initTheme();

  /// Shared preferences.
  SharedPreferences get sharedPreferences;

  /// Photos repository.
  PhotosRepository get photosRepository;

  /// Database.
  Database get db;

  /// Cached photos repository.
  CachedPhotosRepository get cachedPhotosRepository;
}
