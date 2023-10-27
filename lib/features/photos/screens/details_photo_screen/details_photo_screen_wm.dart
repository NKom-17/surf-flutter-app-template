import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
import 'package:flutter_template/features/photos/screens/details_photo_screen/details_photo_screen.dart';
import 'package:flutter_template/features/photos/screens/details_photo_screen/details_photo_screen_model.dart';
import 'package:provider/provider.dart';

/// Factory for [DetailsPhotoScreenWidgetModel].
DetailsPhotoScreenWidgetModel detailsPhotoScreenWmFactory(
  BuildContext context,
) {
  final scope = context.read<IAppScope>();
  final model = DetailsPhotoScreenModel();
  final router = scope.router;
  return DetailsPhotoScreenWidgetModel(model, router);
}

/// Widget model for [DetailsPhotoScreen].
class DetailsPhotoScreenWidgetModel extends WidgetModel<DetailsPhotoScreen, DetailsPhotoScreenModel>
    with ThemeWMMixin
    implements IDetailsPhotoScreenWidgetModel {
  /// Class that coordinates navigation for the whole app.
  final AppRouter router;

  /// Create an instance [DetailsPhotoScreenWidgetModel].
  DetailsPhotoScreenWidgetModel(super._model, this.router);

  @override
  void goBack() {
    router.pop();
  }
}

/// Interface of [IDetailsPhotoScreenWidgetModel].
abstract class IDetailsPhotoScreenWidgetModel extends IWidgetModel with ThemeIModelMixin {
  /// Go back to the previous screen.
  void goBack();
}
