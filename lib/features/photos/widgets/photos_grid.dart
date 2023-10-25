import 'package:flutter/material.dart';
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
  final List<PhotosModel?>? models;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      sliver: SliverGrid.builder(
        itemCount: models?.length,
        itemBuilder: (_, index) {
          final model = models?[index];
          if (model != null) return _PhotoCard(model);
          return null;
        },
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
            fit: BoxFit.cover,
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
