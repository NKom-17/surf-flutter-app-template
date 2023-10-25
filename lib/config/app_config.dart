/// Application configuration.
class AppConfig {
  /// Server url.
  final String url;

  /// Proxy url.
  final String? proxyUrl;

  /// Photos url.
  final String photosUrl;

  /// Client ID parameter when requesting photos.
  final String clientIdOfQueryPhotos;

  /// Create an instance [AppConfig].
  AppConfig({
    required this.url,
    required this.photosUrl,
    required this.clientIdOfQueryPhotos,
    this.proxyUrl,
  });

  /// Create an instance [AppConfig] with modified parameters.
  AppConfig copyWith({
    String? url,
    String? proxyUrl,
    String? photosBaseUrl,
    String? clientIdOfQueryPhotos,
  }) =>
      AppConfig(
        url: url ?? this.url,
        proxyUrl: proxyUrl ?? this.proxyUrl,
        photosUrl: photosBaseUrl ?? this.photosUrl,
        clientIdOfQueryPhotos:
            clientIdOfQueryPhotos ?? this.clientIdOfQueryPhotos,
      );
}
