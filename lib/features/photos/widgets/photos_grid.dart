import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/color_scheme.dart';
import 'package:flutter_template/assets/text/text_extention.dart';
import 'package:flutter_template/features/photos/screens/photos_screen/photos_screen.dart';
import 'package:flutter_template/l10n/app_localizations_x.dart';

/// [PhotosScreen] content
class PhotosGrid extends StatelessWidget {
  /// Create an instance [PhotosGrid].
  const PhotosGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverGrid.builder(
        itemCount: 10,
        itemBuilder: (_, index) {
          return const _PhotoCard();
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
  const _PhotoCard();

  @override
  Widget build(BuildContext context) {
    const numberOfLikes = 14;
    const username = 'Christian';
    final cardShadow = AppColorScheme.of(context).cardShadow;

    return Card(
      elevation: 8,
      shadowColor: cardShadow,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://img.goodfon.com/original/1024x768/c/26/merced-river-yosemite-nationa.jpg',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const _TextInfoOnCard(
                  username,
                  isUsernameText: true,
                ),
                _TextInfoOnCard(context.l10n.likesOnCard(numberOfLikes)),
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
      style: TextStyle(
        fontSize: textTheme.bold12.fontSize,
        fontWeight: isUsernameText
            ? textTheme.bold12.fontWeight
            : textTheme.regular12.fontWeight,
        color: scheme.onPrimary,
      ),
    );
  }
}
