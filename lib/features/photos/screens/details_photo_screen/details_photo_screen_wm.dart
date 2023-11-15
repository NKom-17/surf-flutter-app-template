import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/photos/screens/details_photo_screen/details_photo_screen.dart';
import 'package:flutter_template/features/photos/screens/details_photo_screen/details_photo_screen_model.dart';
import 'package:flutter_template/l10n/app_localizations_x.dart';

/// Factory for [DetailsPhotoScreenWidgetModel].
DetailsPhotoScreenWidgetModel detailsPhotoScreenWmFactory(
  BuildContext context,
) {
  final model = DetailsPhotoScreenModel();
  final router = context.router;
  return DetailsPhotoScreenWidgetModel(model, router);
}

/// Widget model for [DetailsPhotoScreen].
class DetailsPhotoScreenWidgetModel extends WidgetModel<DetailsPhotoScreen, DetailsPhotoScreenModel>
    with ThemeWMMixin
    implements IDetailsPhotoScreenWidgetModel {
  /// Class that coordinates navigation for the whole app.
  final StackRouter router;

  /// Create an instance [DetailsPhotoScreenWidgetModel].
  DetailsPhotoScreenWidgetModel(super._model, this.router);

  @override
  void goBack() {
    router.pop();
  }

  @override
  AppLocalizations get l10n => context.l10n;
}

/// Interface of [IDetailsPhotoScreenWidgetModel].
abstract class IDetailsPhotoScreenWidgetModel extends IWidgetModel with ThemeIModelMixin {
  /// Go back to the previous screen.
  void goBack();

  /// Localization strings.
  AppLocalizations get l10n;
}
