import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_template/features/photos/domain/entity/models/photos_model.dart';
import 'package:flutter_template/features/photos/domain/repositories/proxy_photos_repository.dart';
import 'package:flutter_template/features/photos/screens/photos_screen/photos_screen_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPhotosRepository extends Mock implements ProxyPhotosRepository {}

void main() {
  late PhotosScreenModel model;
  final photosRepository = MockPhotosRepository();

  setUp(() {
    model = PhotosScreenModel(photosRepository);
  });

  group('loading a new page', () {
    when(() => photosRepository.isReady).thenAnswer(
      (_) => Future<void>(() {}),
    );

    test('return empty list', () async {
      when(() => photosRepository.loadingPage(1)).thenAnswer(
        (_) => Future.value([]),
      );

      await model.loadPage();
      expect(
        model.dataState.value.data,
        isEmpty,
        reason: 'Returning an empty list',
      );

      expect(
        model.contentIsOver,
        isTrue,
        reason: 'The content has ended and the loading is not happening',
      );
    });

    test('return data', () async {
      when(() => photosRepository.loadingPage(1)).thenAnswer(
        (_) => Future.value(_photosListMock),
      );

      await model.loadPage();
      expect(model.dataState.value.isContent, isTrue);

      expect(model.dataState.value.data, equals(_photosListMock));
    });

    group('checking the loading status', () {
      test('loading without data', () {
        when(() => photosRepository.loadingPage(1)).thenAnswer(
          (_) => Future.value(_photosListMock),
        );

        model.loadPage().whenComplete(() {
          expect(
            model.dataState.value.isContent,
            isTrue,
            reason: 'Checking the end for the status of the content',
          );
        });

        expect(
          model.dataState.value.isLoading,
          isTrue,
          reason: 'Checking the transition to the loading state',
        );
      });

      test('loading with data', () async {
        when(() => photosRepository.loadingPage(any()))
            .thenAnswer((_) => Future.value(_photosListMock));

        await model.loadPage();

        unawaited(model.loadPage());
        expect(
          model.dataState.value.isLoading,
          isTrue,
          reason: 'Checking the transition to the loading state',
        );

        expect(
          model.dataState.value.data,
          equals(_photosListMock),
          reason: 'Checking data retention when loading',
        );
      });
    });

    group('return failure', () {
      test('failure without data', () async {
        when(() => photosRepository.loadingPage(1))
            .thenThrow(DioError(requestOptions: RequestOptions()));

        expect(
          () => model.loadPage(),
          throwsA(isA<DioError>()),
          reason: 'Checking for throwing an exception',
        );

        await Future.delayed(const Duration(seconds: 2));
        expect(
          model.dataState.value.isFailure,
          isTrue,
          reason: 'Checking the transition to the failure state',
        );
      });

      test('failure with data', () async {
        model.dataState.content(_photosListMock);

        when(() => photosRepository.loadingPage(1))
            .thenThrow(DioError(requestOptions: RequestOptions()));

        expect(
          () => model.loadPage(),
          throwsA(isA<DioError>()),
          reason: 'Checking for throwing an exception',
        );

        await Future.delayed(const Duration(seconds: 2));
        expect(
          model.dataState.value.isFailure,
          isTrue,
          reason: 'Checking the transition to the failure state',
        );

        expect(
          model.dataState.value.data,
          equals(_photosListMock),
          reason: 'Checking data retention when an error occurs',
        );
      });
    });
  });
}

final _photosListMock = List.generate(
  10,
  (index) => const PhotosModel(
    id: 'b5j23b52b',
    photo:
        'https://images.unsplash.com/photo-1695653422715-991ec3a0db7a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wzMzE5MXwxfDF8YWxsfDF8fHx8fHwyfHwxNjk5NDQ2MTE3fA&ixlib=rb-4.0.3&q=80&w=1080',
    username: 'Grab',
    numberOfLikes: 11,
    shadowColor: 0xFFc0c0c0,
    blurImage: 'LWJIIe9F-qV[~XRjS0RibcoyRQRi',
  ),
);
