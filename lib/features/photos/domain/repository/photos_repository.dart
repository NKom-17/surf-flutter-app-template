import 'package:dio/dio.dart';
import 'package:flutter_template/api/service/photos/dtos/photos_dto.dart';
import 'package:flutter_template/config/environment/environment.dart';
import 'package:flutter_template/features/photos/domain/entity/models/photos_model.dart';
import 'package:flutter_template/features/photos/domain/mappers/photos_mapper.dart';

/// Photos repository
class PhotosRepository {
  final Dio _dio;
  final _listPhotos = <PhotosModel>[];

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

    final dtos = <PhotosDTO>[];
    final responseList = response.data as List<dynamic>;
    for (final data in responseList) {
      dtos.add(PhotosDTO.fromJson(data as Map<String, dynamic>));
    }

    _listPhotos.addAll(
      dtos.map((element) => element.toDomain()),
    );

    return _listPhotos;
  }
}
