import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_template/assets/colors/color_scheme.dart';
import 'package:flutter_template/features/photos/domain/entity/models/photos_model.dart';

/// Widget for getting photos from the network.
class PhotoFromNetwork extends StatelessWidget {
  /// Create an instance [PhotoFromNetwork].
  const PhotoFromNetwork(this._model, {super.key, this.isPhotoOnCard = false});

  final PhotosModel _model;

  /// Is this photo on the card or not.
  final bool isPhotoOnCard;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      _model.photo,
      loadingBuilder: (context, child, loadingProgress) {
        return BlurHash(
          hash: _model.blurImage,
          imageFit: BoxFit.cover,
          image: _model.photo,
        );
      },
      errorBuilder: (context, error, stackTrace) {
        final scheme = AppColorScheme.of(context);

        return ColoredBox(
          color: scheme.backgroundErrorImage,
          child: Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              size: isPhotoOnCard ? 24 : 50,
            ),
          ),
        );
      },
    );
  }
}
