/// Application configuration.
class AppConfig {
  /// Server url.
  final String url;

  /// Proxy url.
  final String? proxyUrl;

  /// Base query url to the API.
  final String baseQueryUrl;

  /// Client ID for api requests.
  final String baseQueryClientId;

  /// Create an instance [AppConfig].
  AppConfig({
    required this.url,
    required this.baseQueryUrl,
    required this.baseQueryClientId,
    this.proxyUrl,
  });

  /// Create an instance [AppConfig] with modified parameters.
  AppConfig copyWith({
    String? url,
    String? proxyUrl,
    String? baseQueryUrl,
    String? baseQueryClientId,
  }) =>
      AppConfig(
        url: url ?? this.url,
        proxyUrl: proxyUrl ?? this.proxyUrl,
        baseQueryUrl: baseQueryUrl ?? this.baseQueryUrl,
        baseQueryClientId: baseQueryClientId ?? this.baseQueryClientId,
      );
}
