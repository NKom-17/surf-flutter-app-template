import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_template/assets/colors/color_scheme.dart';
import 'package:flutter_template/assets/text/text_extention.dart';
import 'package:flutter_template/features/photos/domain/entity/models/photos_model.dart';
import 'package:flutter_template/features/photos/screens/photos_screen/photos_screen_export.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:union_state/union_state.dart';

import '../../core/utils/test_widget.dart';

void main() {
  const photosScreen = PhotosScreen();
  final wm = PhotosScreenWMMock();

  testWidget<PhotosScreen>(
    skip: true,
    screenState: 'initial_unknown_error',
    widgetBuilder: (_) => photosScreen.build(wm),
    setup: (themeData, themeMode, l10n) {
      when(() => wm.dataState).thenAnswer(
        (_) => UnionStateNotifier<List<PhotosModel>>.failure(),
      );

      when(() => wm.scrollController).thenAnswer((_) => ScrollController());

      when(() => wm.textScheme).thenReturn(themeData.customTextTheme);
      when(() => wm.colorScheme).thenReturn(themeData.customColorScheme);
      when(() => wm.l10n).thenReturn(l10n);
    },
  );

  testWidget<PhotosScreen>(
    skip: true,
    screenState: 'initial_loading',
    widgetBuilder: (_) => photosScreen.build(wm),
    setup: (themeData, themeMode, l10n) {
      when(() => wm.dataState).thenReturn(
        UnionStateNotifier<List<PhotosModel>>.loading(),
      );

      when(() => wm.scrollController).thenReturn(ScrollController());

      when(() => wm.textScheme).thenReturn(themeData.customTextTheme);
      when(() => wm.colorScheme).thenReturn(themeData.customColorScheme);
      when(() => wm.l10n).thenReturn(l10n);
    },
    test: (tester, theme) async {
      // await tester.pumpWidgetBuilder(photosScreen.build(wm));
      await tester.pump(const Duration(seconds: 1));
      // await multiScreenGolden(tester, 'initial_loading');
    },
  );

  testWidget<PhotosScreen>(
      // skip: true,
      screenState: 'content',
      widgetBuilder: (_) => photosScreen.build(wm),
      setup: (themeData, themeMode, l10n) {
        when(() => wm.dataState).thenReturn(
          UnionStateNotifier<List<PhotosModel>>(_photosModelsMock),
        );

        when(() => wm.scrollController).thenReturn(ScrollController());

        when(() => wm.textScheme).thenReturn(themeData.customTextTheme);
        when(() => wm.colorScheme).thenReturn(themeData.customColorScheme);
        when(() => wm.l10n).thenReturn(l10n);
      },
      test: (tester, _) async {
        return await mockNetworkImages(() async => tester.pumpWidget(photosScreen.build(wm)));
      });

  testGoldens('golden_content', (tester) async {
    when(() => wm.dataState).thenReturn(
      UnionStateNotifier<List<PhotosModel>>(_photosModelsMock),
    );

    when(() => wm.scrollController).thenReturn(ScrollController());

    when(() => wm.textScheme).thenReturn(TextThemeMock());
    when(() => wm.colorScheme).thenReturn(ColorSchemeMock());
    when(() => wm.l10n).thenReturn(LocalizationMock());

    // await tester.pumpWidget(photosScreen.build(wm));
    await mockNetworkImages(
      () async => tester.pumpWidget(
        MaterialApp(home: photosScreen.build(wm)),
      ),
    );
    await multiScreenGolden(tester, 'content');
  });
}

class PhotosScreenWMMock extends Mock implements IPhotosScreenWidgetModel {}

// class ThemeMock extends Mock implements ThemeIModelMixin {}
class ColorSchemeMock extends Mock implements AppColorScheme {}

class TextThemeMock extends Mock implements AppTextTheme {}

class LocalizationMock extends Mock implements AppLocalizations {}

final _photosModelsMock = List.generate(
  10,
  (index) => const PhotosModel(
    photo:
        'https://images.unsplash.com/photo-1695653422715-991ec3a0db7a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wzMzE5MXwxfDF8YWxsfDF8fHx8fHwyfHwxNjk5NDQ2MTE3fA&ixlib=rb-4.0.3&q=80&w=1080',
    username: 'Grab',
    numberOfLikes: 11,
    shadowColor: 0xFFc0c0c0,
    blurImage: 'LWJIIe9F-qV[~XRjS0RibcoyRQRi',
  ),
);
