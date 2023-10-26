import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'urls_data_dto.g.dart';

/// DTO model of image links.
@immutable
@JsonSerializable()
class UrlsDataDTO {
  /// Image
  final String regular;

  /// Create an instance [UrlsDataDTO].
  const UrlsDataDTO(this.regular);

  /// Deserialization of the received data
  factory UrlsDataDTO.fromJson(Map<String, dynamic> json) => _$UrlsDataDTOFromJson(json);
}
