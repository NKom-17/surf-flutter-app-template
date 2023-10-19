import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/features/common/mixin/theme_mixin.dart';
import 'package:flutter_template/features/photos/screens/photos_screen/photos_screen.dart';
import 'package:flutter_template/features/photos/screens/photos_screen/photos_screen_model.dart';

/// Factory for [PhotosScreenWidgetModel].
PhotosScreenWidgetModel photosScreenWmFactory(
  BuildContext context,
) {
  final model = PhotosScreenModel();
  return PhotosScreenWidgetModel(model);
}

/// Widget model for [PhotosScreen].
class PhotosScreenWidgetModel extends WidgetModel<PhotosScreen, PhotosScreenModel>
    with ThemeWMMixin
    implements IPhotosScreenWidgetModel {
  /// Create an instance [PhotosScreenWidgetModel].
  PhotosScreenWidgetModel(super._model);
}

/// Interface of [PhotosScreenWidgetModel].
abstract class IPhotosScreenWidgetModel extends IWidgetModel
    with ThemeIModelMixin {}
