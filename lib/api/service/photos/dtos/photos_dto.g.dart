// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photos_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotosDTO _$PhotosDTOFromJson(Map<String, dynamic> json) => PhotosDTO(
      urls: UrlsDataDTO.fromJson(json['urls'] as Map<String, dynamic>),
      user: UserDataDTO.fromJson(json['user'] as Map<String, dynamic>),
      likes: json['likes'] as int,
      color: json['color'] as String,
      blurImage: json['blur_hash'] as String,
    );

Map<String, dynamic> _$PhotosDTOToJson(PhotosDTO instance) => <String, dynamic>{
      'urls': instance.urls,
      'user': instance.user,
      'likes': instance.likes,
      'color': instance.color,
      'blur_hash': instance.blurImage,
    };
