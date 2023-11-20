import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/color_scheme.dart';
import 'package:flutter_template/assets/text/text_extention.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
import 'package:flutter_template/features/photos/domain/entity/custom_button/custom_button.dart';
import 'package:flutter_template/features/photos/domain/entity/custom_button/custom_button_builder.dart';
import 'package:flutter_template/features/photos/domain/entity/models/photos_model.dart';
import 'package:flutter_template/features/photos/screens/details_photo_screen/details_photo_screen_wm.dart';
import 'package:flutter_template/features/photos/screens/photos_screen/photos_screen.dart';
import 'package:flutter_template/features/photos/widgets/photo_from_network.dart';
import 'package:flutter_template/l10n/app_localizations_x.dart';

/// Widget detailed information about a photo from [PhotosScreen].
@RoutePage(
  name: AppRouteNames.detailsPhotoScreen,
)
class DetailsPhotoScreen extends ElementaryWidget<IDetailsPhotoScreenWidgetModel> {
  /// Create an instance [DetailsPhotoScreen].
  const DetailsPhotoScreen({
    required PhotosModel model,
    Key? key,
    WidgetModelFactory wmFactory = detailsPhotoScreenWmFactory,
  })  : _model = model,
        super(wmFactory, key: key);

  final PhotosModel _model;

  @override
  Widget build(IDetailsPhotoScreenWidgetModel wm) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              _Image(
                model: _model,
                addedToFavorites: wm.addedToFavorites,
                addedToBookmarks: wm.addedToBookmarks,
                tapOnFavoritesButton: wm.tapOnFavoritesButton,
                tapOnBookmarkButton: wm.tapOnBookmarksButton,
              ),
              _GoBackButton(wm.goBack),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _DownloadImage(),
                const SizedBox(height: 10),
                _InfoAboutPhoto(_model),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GoBackButton extends StatelessWidget {
  const _GoBackButton(this.goBack);

  final VoidCallback goBack;

  @override
  Widget build(BuildContext context) {
    final scheme = AppColorScheme.of(context);
    final textTheme = AppTextTheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
      child: Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: goBack,
          child: Row(
            children: [
              Icon(
                Icons.keyboard_arrow_left,
                color: scheme.textOnImage,
                size: 16,
              ),
              const SizedBox(width: 3),
              Text(
                context.l10n.backButton,
                style: textTheme.regular16.copyWith(color: scheme.textOnImage),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    required this.model,
    required this.addedToFavorites,
    required this.addedToBookmarks,
    required this.tapOnFavoritesButton,
    required this.tapOnBookmarkButton,
  });

  final PhotosModel model;
  final ListenableState<bool> addedToFavorites;
  final ListenableState<bool> addedToBookmarks;
  final void Function() tapOnFavoritesButton;
  final void Function() tapOnBookmarkButton;

  @override
  Widget build(BuildContext context) {
    final heightImage = MediaQuery.of(context).size.height * 0.4;
    final scheme = AppColorScheme.of(context);

    final favoriteButton = CustomButtonBuilder(
      tapOnFavoritesButton,
      icon: Icons.favorite,
      pressedIcon: Icons.favorite_border,
      iconColor: scheme.favoriteIcon,
      iconSize: 22,
      backgroundColor: scheme.backgroundColorOfButtonsOnImage,
    ).toBuild();

    final bookmarkButton = CustomButtonBuilder(
      tapOnBookmarkButton,
      icon: Icons.bookmark,
      pressedIcon: Icons.bookmark_border,
      iconColor: scheme.bookmarkIcon,
      iconSize: 22,
      backgroundColor: scheme.backgroundColorOfButtonsOnImage,
    ).toBuild();

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),
      child: SizedBox(
        height: heightImage,
        width: double.infinity,
        child: Stack(
          children: [
            PhotoFromNetwork(model),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
              child: Align(
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _ButtonOnImage(favoriteButton, addedToFavorites),
                    const SizedBox(width: 10),
                    _ButtonOnImage(bookmarkButton, addedToBookmarks),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoAboutPhoto extends StatelessWidget {
  const _InfoAboutPhoto(this.model);

  final PhotosModel model;

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTextTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          model.username,
          style: textTheme.bold26,
        ),
        Text(
          context.l10n.likesOnCard(model.numberOfLikes),
          style: textTheme.medium14,
        ),
      ],
    );
  }
}

class _ButtonOnImage extends StatelessWidget {
  const _ButtonOnImage(this.button, this.buttonIsPressed);

  final CustomButton button;
  final ListenableState<bool> buttonIsPressed;

  @override
  Widget build(BuildContext context) {
    return StateNotifierBuilder(
      listenableState: buttonIsPressed,
      builder: (context, buttonIsPressed) {
        return GestureDetector(
          onTap: button.onTap,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: button.backgroundColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(
                buttonIsPressed! ? button.icon : button.pressedIcon,
                color: button.iconColor,
                size: button.iconSize,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DownloadImage extends StatelessWidget {
  const _DownloadImage();

  @override
  Widget build(BuildContext context) {
    final scheme = AppColorScheme.of(context);
    final textTheme = AppTextTheme.of(context);

    final downloadButton = CustomButtonBuilder(
      () {},
      text: context.l10n.downloadImageButton,
      textColor: scheme.onBackground,
      textStyle: textTheme.medium14,
      icon: Icons.download,
      iconColor: scheme.primary,
      iconSize: 20,
      backgroundColor: scheme.background,
    ).toBuild();

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: downloadButton.backgroundColor,
        shadowColor: scheme.primary,
        side: BorderSide(
          color: scheme.primary,
          width: 0.2,
        ),
      ),
      // TODO(NKom-17): добавить логику скачивания изображения
      onPressed: () {},
      icon: Icon(
        downloadButton.icon,
        color: scheme.primary,
        size: downloadButton.iconSize,
      ),
      label: Text(
        downloadButton.text ?? '',
        style: downloadButton.textStyle?.copyWith(
          color: downloadButton.textColor,
        ),
      ),
    );
  }
}
