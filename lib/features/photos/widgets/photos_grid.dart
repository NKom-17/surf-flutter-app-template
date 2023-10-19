import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/color_scheme.dart';
import 'package:flutter_template/features/photos/screens/photos_screen/photos_screen.dart';

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
        itemBuilder: (context, index) {
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
    const quantity = 14;
    const username = 'Christian';
    final shadowColor = AppColorScheme.of(context).onBackground;

    return Card(
      elevation: 8,
      shadowColor: shadowColor,
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
          const Padding(
            padding: EdgeInsets.only(left: 20, bottom: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _TextInfoOnCard(
                  text: username,
                  isUsernameText: true,
                ),
                _TextInfoOnCard(text: '$quantity likes'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TextInfoOnCard extends StatelessWidget {
  const _TextInfoOnCard({
    required this.text,
    this.isUsernameText = false,
  });

  final String text;
  final bool isUsernameText;

  @override
  Widget build(BuildContext context) {
    final scheme = AppColorScheme.of(context);

    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        fontWeight: isUsernameText ? FontWeight.w600 : null,
        color: scheme.onPrimary,
      ),
    );
  }
}
