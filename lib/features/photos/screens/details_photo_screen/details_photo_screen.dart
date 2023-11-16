import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/assets/colors/color_scheme.dart';
import 'package:flutter_template/assets/text/text_extention.dart';
import 'package:flutter_template/features/navigation/domain/entity/app_route_names.dart';
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
              _Image(_model),
              _GoBackButton(wm.goBack),
            ],
          ),
          _InfoAboutPhoto(_model),
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
  const _Image(this.model);

  final PhotosModel model;

  @override
  Widget build(BuildContext context) {
    final heightImage = MediaQuery.of(context).size.height * 0.4;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(30),
      ),
      child: SizedBox(
        height: heightImage,
        width: double.infinity,
        child: PhotoFromNetwork(model),
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

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
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
      ),
    );
  }
}
