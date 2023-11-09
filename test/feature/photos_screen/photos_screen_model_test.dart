import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_template/api/service/photos/dtos/photos_dto.dart';
import 'package:flutter_template/api/service/photos/dtos/urls_data_dto.dart';
import 'package:flutter_template/api/service/photos/dtos/user_data_dto.dart';
import 'package:flutter_template/features/photos/domain/mappers/photos_mapper.dart';
import 'package:flutter_template/features/photos/domain/repository/photos_repository.dart';
import 'package:flutter_template/features/photos/screens/photos_screen/photos_screen_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPhotosRepository extends Mock implements PhotosRepository {}

void main() {
  late PhotosScreenModel model;
  final photosRepository = MockPhotosRepository();

  setUp(() {
    model = PhotosScreenModel(photosRepository);
  });

  group('loading a new page', () {
    test('return empty list', () async {
      when(() => photosRepository.loadingPage(1)).thenAnswer(
        (_) => Future.value([]),
      );
      await model.loadPage();
      expect(model.dataState.value.data, isEmpty);
    });

    test('return data', () async {
      when(() => photosRepository.loadingPage(1)).thenAnswer(
        (_) => Future.value(_photosDTOListMock),
      );

      await model.loadPage();
      expect(model.dataState.value.isContent, isTrue);

      final photosModelListMock = _photosDTOListMock.map((e) => e.toDomain()).toList();
      expect(model.dataState.value.data, equals(photosModelListMock));
    });

    test('checking the loading status', () async {
      when(() => photosRepository.loadingPage(1)).thenAnswer(
        (_) => Future.value(_photosDTOListMock),
      );

      unawaited(model.loadPage());
      expect(
        model.dataState.value.isLoading,
        isTrue,
        reason: 'Checking the transition to the loading state',
      );

      await model.loadPage();
      expect(
        model.dataState.value.isContent,
        isTrue,
        reason: 'Checking the end for the status of the content',
      );
    });

    test('checking the loading status with data', () async {
      when(() => photosRepository.loadingPage(1))
          .thenAnswer((_) => Future.value(_photosDTOListMock));
      when(() => photosRepository.loadingPage(2))
          .thenAnswer((_) => Future.value(_photosDTOListMock));

      await model.loadPage();

      unawaited(model.loadPage());
      expect(
        model.dataState.value.isLoading,
        isTrue,
        reason: 'Checking the transition to the loading state',
      );

      final photosModelListMock = _photosDTOListMock.map((e) => e.toDomain()).toList();
      expect(
        model.dataState.value.data,
        equals(photosModelListMock),
        reason: 'Checking data retention when loading',
      );
    });

    test('return failure', () async {
      when(() => photosRepository.loadingPage(1)).thenAnswer(
        (_) => Future.error(
          DioError(requestOptions: RequestOptions()),
        ),
      );

      try {
        await model.loadPage();
      } on DioError catch (_) {
        return;
      }
      expect(model.dataState.value.isFailure, isTrue);
    });

    test('return failure with data', () async {
      final data = _photosDTOListMock;
      when(() => photosRepository.loadingPage(1)).thenAnswer(
        (_) => Future.error(
          DioError(requestOptions: RequestOptions()),
        ),
      );

      try {
        await model.loadPage();
      } on DioError catch (_) {
        return Future.value(data);
      }

      expect(
        model.dataState.value.isFailure,
        isTrue,
        reason: 'Checking the transition to the failure state',
      );
      expect(
        model.dataState.value.data,
        equals(data.map((e) => e.toDomain()).toList()),
        reason: 'Checking data retention when an error occurs',
      );
    });
  });
}

final _photosDTOListMock = List.generate(
  10,
  (index) => const PhotosDTO(
    urls: UrlsDataDTO(
      'https://images.unsplash.com/photo-1695653422715-991ec3a0db7a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wzMzE5MXwxfDF8YWxsfDF8fHx8fHwyfHwxNjk5NDQ2MTE3fA&ixlib=rb-4.0.3&q=80&w=1080',
    ),
    user: UserDataDTO('Grab'),
    likes: 11,
    color: '#c0c0c0',
    blurImage: 'LWJIIe9F-qV[~XRjS0RibcoyRQRi',
  ),
);
