import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/photos/domain/entity/models/photos_model.dart';
import 'package:flutter_template/features/photos/screens/photos_screen/photos_screen.dart';
import 'package:flutter_template/features/photos/screens/photos_screen/photos_screen_model.dart';
import 'package:flutter_template/l10n/app_localizations_x.dart';
import 'package:provider/provider.dart';
import 'package:union_state/union_state.dart';

/// Factory for [PhotosScreenWidgetModel].
PhotosScreenWidgetModel photosScreenWmFactory(
  BuildContext context,
) {
  // final networkErrorMessage = context.l10n.networkErrorMessage;
  final scope = context.read<IAppScope>();
  final model = PhotosScreenModel(scope);
  return PhotosScreenWidgetModel(model);
}

/// Widget model for [PhotosScreen].
class PhotosScreenWidgetModel
    extends WidgetModel<PhotosScreen, PhotosScreenModel>
    with ThemeWMMixin
    implements IPhotosScreenWidgetModel {
  /// Create an instance [PhotosScreenWidgetModel].
  PhotosScreenWidgetModel(super._model);

  @override
  ValueListenable<UnionState<List<PhotosModel>>> get dataState =>
      model.dataState;

  @override
  AppLocalizations get l10n => context.l10n;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    model.loadPage();
  }

  /// Load the next page
  void loadNextPage() {
    model.loadPage();
  }
}

/// Interface of [PhotosScreenWidgetModel].
abstract class IPhotosScreenWidgetModel extends IWidgetModel
    with ThemeIModelMixin {
  /// Interface for data with a loading state
  ValueListenable<UnionState<List<PhotosModel>>> get dataState;

  /// Localization strings.
  AppLocalizations get l10n;
}
