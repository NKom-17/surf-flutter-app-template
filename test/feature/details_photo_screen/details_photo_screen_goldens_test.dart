import 'package:elementary/elementary.dart';
import 'package:flutter_template/features/photos/domain/entity/models/photos_model.dart';
import 'package:flutter_template/features/photos/screens/details_photo_screen/details_photo_screen_export.dart';
import 'package:flutter_template/features/photos/screens/photos_screen/photos_screen_export.dart';
import 'package:mocktail/mocktail.dart';

import '../../core/utils/test_widget.dart';

void main() {
  const detailsPhotoScreen = DetailsPhotoScreen(model: _photosModelMock);
  final wm = DetailsPhotosScreenWMMock();

  testWidget<PhotosScreen>(
    desc: 'details photo screen with data',
    onlyOneTheme: true,
    widgetBuilder: (_) => detailsPhotoScreen.build(wm),
    setup: (themeData, themeMode, l10n) {
      when(() => wm.textScheme).thenReturn(themeData.customTextTheme);
      when(() => wm.colorScheme).thenReturn(themeData.customColorScheme);
      when(() => wm.l10n).thenReturn(l10n);
      when(() => wm.addedToFavorites).thenAnswer((_) => StateNotifier<bool>(initValue: false));
      when(() => wm.addedToBookmarks).thenAnswer((_) => StateNotifier<bool>(initValue: false));
    },
  );
}

class DetailsPhotosScreenWMMock extends Mock implements IDetailsPhotoScreenWidgetModel {}

const _photosModelMock = PhotosModel(
  photo:
      'https://images.unsplash.com/photo-1695653422715-991ec3a0db7a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wzMzE5MXwxfDF8YWxsfDF8fHx8fHwyfHwxNjk5NDQ2MTE3fA&ixlib=rb-4.0.3&q=80&w=1080',
  username: 'Grab',
  numberOfLikes: 11,
  shadowColor: 0xFFe055ff,
  blurImage: 'LWJIIe9F-qV[~XRjS0RibcoyRQRi',
);
