import 'package:dio/dio.dart';
import 'package:flutter_template/api/service/photos/dtos/photos_dto.dart';
import 'package:flutter_template/config/environment/environment.dart';
import 'package:flutter_template/features/photos/domain/entity/models/photos_model.dart';
import 'package:flutter_template/features/photos/domain/mappers/photos_mapper.dart';

/// Photos repository
class PhotosRepository {
  final Dio _dio;

  /// Create an instance [PhotosRepository].
  PhotosRepository(this._dio);

  /// Page loading
  Future<List<PhotosModel?>> loadingPage(String page) async {
    const urlPhotos = '/photos';
    final response = await _dio.get(
      urlPhotos,
      queryParameters: {
        'page': page,
        'client_id': Environment.instance().config.baseQueryClientId,
      },
    );

    final dtos = <PhotosDTO>[];
    final responseList = response.data as List<dynamic>;
    for (final data in responseList) {
      dtos.add(PhotosDTO.fromJson(data as Map<String, dynamic>));
    }

    final listPhotosModels = <PhotosModel>[];
    for (final dto in dtos) {
      listPhotosModels.add(dto.toDomain());
    }

    return listPhotosModels;
  }
}
