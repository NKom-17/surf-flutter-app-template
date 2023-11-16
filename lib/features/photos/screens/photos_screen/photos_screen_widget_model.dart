import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_template/features/app/di/app_scope.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/navigation/service/router.dart';
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
  final scope = context.read<IAppScope>();
  final model = PhotosScreenModel(scope.photosRepository);
  final router = context.router;
  return PhotosScreenWidgetModel(model, router);
}

/// Widget model for [PhotosScreen].
class PhotosScreenWidgetModel extends WidgetModel<PhotosScreen, PhotosScreenModel>
    with ThemeWMMixin
    implements IPhotosScreenWidgetModel {
  @override
  ValueListenable<UnionState<List<PhotosModel>>> get dataState => model.dataState;

  @override
  final scrollController = ScrollController();

  /// Class that coordinates navigation for the whole app.
  final StackRouter router;

  @override
  AppLocalizations get l10n => context.l10n;

  /// Create an instance [PhotosScreenWidgetModel].
  PhotosScreenWidgetModel(super._model, this.router);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    model.loadPage();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
          !dataState.value.isLoading) {
        loadNextPage();
      }
    });
  }

  /// Load the next page.
  Future<void> loadNextPage() async {
    try {
      await model.loadPage();
    } on DioError catch (e) {
      var handledException = Exception(e.error);
      if (e.error != null && e.error is SocketException) handledException = e.error! as Exception;
      showErrorSnackBar(handledException);
    }
  }

  /// Show a snack bar with an error.
  void showErrorSnackBar(Exception exception) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            exception is SocketException ? context.l10n.networkErrorMessage : exception.toString(),
          ),
        ),
      );
  }

  @override
  void openDetailsPhoto(PhotosModel model) {
    router.push(DetailsPhotoRouter(model: model));
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

/// Interface of [PhotosScreenWidgetModel].
abstract class IPhotosScreenWidgetModel extends IWidgetModel with ThemeIModelMixin {
  /// Interface for data with a loading state.
  ValueListenable<UnionState<List<PhotosModel>>> get dataState;

  /// Scroll controller for custom scroll view.
  ScrollController get scrollController;

  /// Navigate to details photo screen.
  void openDetailsPhoto(PhotosModel model) {}

  /// Localization strings.
  AppLocalizations get l10n;
}
