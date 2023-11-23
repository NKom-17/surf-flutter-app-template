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
  Future<List<PhotosModel>> loadingPage(int page) async {
    const urlPhotos = '/photos';
    final response = await _dio.get(
      urlPhotos,
      queryParameters: {
        'page': page,
        'client_id': Environment.instance().config.clientIdOfQueryPhotos,
      },
    );

    final models = response.data as List<dynamic>;

    return models
        .map((data) => PhotosDTO.fromJson(data as Map<String, dynamic>))
        .map(PhotosMapper.fromDTO)
        .toList();
  }
}
