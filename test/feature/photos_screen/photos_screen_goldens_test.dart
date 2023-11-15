import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_template/features/photos/domain/entity/models/photos_model.dart';
import 'package:flutter_template/features/photos/screens/photos_screen/photos_screen_export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:union_state/union_state.dart';

import '../../core/utils/test_widget.dart';

void main() {
  const photosScreen = PhotosScreen();
  final wm = PhotosScreenWMMock();

  group('initial_error', () {
    testWidget<PhotosScreen>(
      screenState: 'initial_unknown_error',
      onlyOneTheme: true,
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
      screenState: 'initial_network_error',
      onlyOneTheme: true,
      widgetBuilder: (_) => photosScreen.build(wm),
      setup: (themeData, themeMode, l10n) {
        const networkException = SocketException('');

        when(() => wm.dataState).thenAnswer(
          (_) => UnionStateNotifier<List<PhotosModel>>.failure(networkException),
        );

        when(() => wm.scrollController).thenAnswer((_) => ScrollController());
        when(() => wm.textScheme).thenReturn(themeData.customTextTheme);
        when(() => wm.colorScheme).thenReturn(themeData.customColorScheme);
        when(() => wm.l10n).thenReturn(l10n);
      },
    );
  });

  group('loading', () {
    testWidget<PhotosScreen>(
      screenState: 'initial_loading',
      onlyOneTheme: true,
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
    );

    testWidget<PhotosScreen>(
      screenState: 'loading_with_data',
      onlyOneTheme: true,
      widgetBuilder: (_) => photosScreen.build(wm),
      setup: (themeData, themeMode, l10n) {
        when(() => wm.dataState).thenAnswer(
          (_) => UnionStateNotifier<List<PhotosModel>>.loading(_photosModelsMock),
        );

        when(() => wm.scrollController).thenReturn(ScrollController());
        when(() => wm.textScheme).thenReturn(themeData.customTextTheme);
        when(() => wm.colorScheme).thenReturn(themeData.customColorScheme);
        when(() => wm.l10n).thenReturn(l10n);
      },
      test: (tester, theme) async {
        final customScrollView = tester.widget<CustomScrollView>(find.byType(CustomScrollView));
        final controller = customScrollView.controller;
        controller?.jumpTo(controller.position.maxScrollExtent);
        await tester.pump();
      },
    );
  });

  group('content', () {
    testWidget<PhotosScreen>(
      screenState: 'content',
      onlyOneTheme: true,
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
    );

    testWidget<PhotosScreen>(
      screenState: 'empty_content',
      onlyOneTheme: true,
      widgetBuilder: (_) => photosScreen.build(wm),
      setup: (themeData, themeMode, l10n) {
        when(() => wm.dataState).thenReturn(
          UnionStateNotifier<List<PhotosModel>>([]),
        );

        when(() => wm.scrollController).thenReturn(ScrollController());
        when(() => wm.textScheme).thenReturn(themeData.customTextTheme);
        when(() => wm.colorScheme).thenReturn(themeData.customColorScheme);
        when(() => wm.l10n).thenReturn(l10n);
      },
    );
  });

  testWidget<PhotosScreen>(
    screenState: 'network_error_with_data',
    onlyOneTheme: true,
    widgetBuilder: (_) => photosScreen.build(wm),
    setup: (themeData, themeMode, l10n) async {
      const networkException = SocketException('');

      when(() => wm.dataState).thenReturn(
        UnionStateNotifier<List<PhotosModel>>.failure(networkException, _photosModelsMock),
      );

      when(() => wm.scrollController).thenReturn(ScrollController());
      when(() => wm.textScheme).thenReturn(themeData.customTextTheme);
      when(() => wm.colorScheme).thenReturn(themeData.customColorScheme);
      when(() => wm.l10n).thenReturn(l10n);
    },
  );
}

class PhotosScreenWMMock extends Mock implements IPhotosScreenWidgetModel {}

final _photosModelsMock = List.generate(
  10,
  (index) => const PhotosModel(
    photo:
        'https://images.unsplash.com/photo-1695653422715-991ec3a0db7a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wzMzE5MXwxfDF8YWxsfDF8fHx8fHwyfHwxNjk5NDQ2MTE3fA&ixlib=rb-4.0.3&q=80&w=1080',
    username: 'Grab',
    numberOfLikes: 11,
    shadowColor: 0xFFe055ff,
    blurImage: 'LWJIIe9F-qV[~XRjS0RibcoyRQRi',
  ),
);
