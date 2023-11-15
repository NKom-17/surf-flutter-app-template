import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_template/assets/colors/color_scheme.dart';
import 'package:flutter_template/features/photos/domain/entity/models/photos_model.dart';
import 'package:flutter_template/util/evn/test_environment_detector.dart';

/// Widget for getting photos from the network.
class PhotoFromNetwork extends StatefulWidget {
  /// Create an instance [PhotoFromNetwork].
  const PhotoFromNetwork(this._model, {super.key, this.isPhotoOnCard = false});

  final PhotosModel _model;

  /// Is this photo on the card or not.
  final bool isPhotoOnCard;

  @override
  State<PhotoFromNetwork> createState() => _PhotoFromNetworkState();
}

class _PhotoFromNetworkState extends State<PhotoFromNetwork> {
  late final bool isTestEnv;

  @override
  void initState() {
    super.initState();

    isTestEnv = TestEnvironmentDetector.isTestEnvironment;
  }

  @override
  Widget build(BuildContext context) {
    if (isTestEnv) return const _TestImage();

    return Image.network(
      widget._model.photo,
      loadingBuilder: (context, child, loadingProgress) {
        return BlurHash(
          hash: widget._model.blurImage,
          imageFit: BoxFit.cover,
          image: widget._model.photo,
        );
      },
      errorBuilder: (context, error, stackTrace) {
        final scheme = AppColorScheme.of(context);

        return ColoredBox(
          color: scheme.backgroundErrorImage,
          child: Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              size: widget.isPhotoOnCard ? 24 : 50,
            ),
          ),
        );
      },
    );
  }
}

class _TestImage extends StatelessWidget {
  const _TestImage();

  @override
  Widget build(BuildContext context) {
    final scheme = AppColorScheme.of(context);

    return ColoredBox(
      color: scheme.primary,
      child: Center(
        child: Icon(
          Icons.photo_outlined,
          size: 50,
          color: scheme.onPrimary,
        ),
      ),
    );
  }
}
