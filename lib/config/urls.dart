import 'package:flutter_template/config/environment/environment.dart';

/// Server urls.
abstract class Url {
  /// TRest url.
  static String get testUrl => 'https://api.unsplash.com';

  /// Prod url.
  static String get prodUrl => 'https://prod.surfstudio.ru/api';

  /// Dev url.
  static String get devUrl => 'https://localhost:9999/food/hs/ExchangeSotr';

  /// Base url.
  static String get baseUrl => Environment.instance().config.url;

  /// Client ID for requesting photos.
  static String get clientIdOfQueryPhotos =>
      '896d4f52c589547b2134bd75ed48742db637fa51810b49b607e37e46ab2c0043';
}
