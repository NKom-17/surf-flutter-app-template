/// Application configuration.
class AppConfig {
  /// Server url.
  final String url;

  /// Proxy url.
  final String? proxyUrl;

  /// The base URL of the photos.
  final String photosBaseUrl;

  /// Client ID parameter when requesting photos.
  final String clientIdOfQueryPhotos;

  /// Create an instance [AppConfig].
  AppConfig({
    required this.url,
    required this.photosBaseUrl,
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
        photosBaseUrl: photosBaseUrl ?? this.photosBaseUrl,
        clientIdOfQueryPhotos:
            clientIdOfQueryPhotos ?? this.clientIdOfQueryPhotos,
      );
}
