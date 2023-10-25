import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_data_dto.g.dart';

/// The DTO model of information about the author.
@immutable
@JsonSerializable()
class UserDataDTO {
  /// Name of the author of the photo
  final String username;

  /// Create an instance [UserDataDTO].
  const UserDataDTO(this.username);

  /// Deserialization of the received data
  factory UserDataDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDataDTOFromJson(json);
}
