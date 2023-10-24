import 'package:flutter_template/config/environment/environment.dart';

/// Server urls.
abstract class Url {
  /// TRest url.
  static String get testUrl => 'http://uinames.com/api/';

  /// Prod url.
  static String get prodUrl => 'https://prod.surfstudio.ru/api';

  /// Dev url.
  static String get devUrl => 'https://localhost:9999/food/hs/ExchangeSotr';

  /// Base url.
  static String get baseUrl => Environment.instance().config.url;

  /// Base query url.
  static String get baseQueryUrl => 'https://api.unsplash.com';

  /// Base query client id.
  static String get baseQueryClientId =>
      '896d4f52c589547b2134bd75ed48742db637fa51810b49b607e37e46ab2c0043';
}
