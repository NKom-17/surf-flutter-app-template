import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_template/assets/colors/color_scheme.dart';
import 'package:flutter_template/assets/text/text_extention.dart';
import 'package:flutter_template/features/photos/domain/entity/models/photos_model.dart';
import 'package:flutter_template/features/photos/screens/photos_screen/photos_screen.dart';
import 'package:flutter_template/l10n/app_localizations_x.dart';

/// [PhotosScreen] content
class PhotosGrid extends StatelessWidget {
  /// Create an instance [PhotosGrid].
  const PhotosGrid(this.models, {super.key});

  /// List of [PhotosModel]
  final List<PhotosModel>? models;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final model = models?[index];
            if (model != null) return _PhotoCard(model);
            return null;
          },
          childCount: models?.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
      ),
    );
  }
}

class _PhotoCard extends StatelessWidget {
  const _PhotoCard(this.model);

  final PhotosModel model;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Color(model.shadowColor),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            model.photo,
            loadingBuilder: (context, child, loadingProgress) {
              return BlurHash(
                hash: model.blurImage,
                imageFit: BoxFit.cover,
                image: model.photo,
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.image_not_supported_outlined);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _TextInfoOnCard(
                  model.username,
                  isUsernameText: true,
                ),
                _TextInfoOnCard(context.l10n.likesOnCard(model.numberOfLikes)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TextInfoOnCard extends StatelessWidget {
  const _TextInfoOnCard(this.text, {this.isUsernameText = false});

  final String text;
  final bool isUsernameText;

  @override
  Widget build(BuildContext context) {
    final scheme = AppColorScheme.of(context);
    final textTheme = AppTextTheme.of(context);

    return Text(
      text,
      style: textTheme.regular12.copyWith(
        color: scheme.onPrimary,
        fontWeight: isUsernameText ? textTheme.bold12.fontWeight : textTheme.regular12.fontWeight,
      ),
    );
  }
}
