import 'dart:io';

import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  final scope = context.read<IAppScope>();
  final model = PhotosScreenModel(scope);
  return PhotosScreenWidgetModel(model);
}

/// Widget model for [PhotosScreen].
class PhotosScreenWidgetModel extends WidgetModel<PhotosScreen, PhotosScreenModel>
    with ThemeWMMixin
    implements IPhotosScreenWidgetModel {
  @override
  ValueListenable<UnionState<List<PhotosModel>>> get dataState => model.dataState;

  @override
  final scrollController = ScrollController();

  /// Create an instance [PhotosScreenWidgetModel].
  PhotosScreenWidgetModel(super._model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    model.loadPage();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
          !model.dataStateStatus.isLoading) {
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
}
