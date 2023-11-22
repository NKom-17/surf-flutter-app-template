// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CachedPhotosTableTable extends CachedPhotosTable
    with TableInfo<$CachedPhotosTableTable, CachedPhotosTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;

  $CachedPhotosTableTable(this.attachedDatabase, [this._alias]);

  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>('id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _photoMeta = const VerificationMeta('photo');
  @override
  late final GeneratedColumn<String> photo = GeneratedColumn<String>('photo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _usernameMeta = const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _numberOfLikesMeta = const VerificationMeta('numberOfLikes');
  @override
  late final GeneratedColumn<int> numberOfLikes = GeneratedColumn<int>(
      'number_of_likes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _shadowColorMeta = const VerificationMeta('shadowColor');
  @override
  late final GeneratedColumn<int> shadowColor = GeneratedColumn<int>(
      'shadow_color', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _blurImageMeta = const VerificationMeta('blurImage');
  @override
  late final GeneratedColumn<String> blurImage = GeneratedColumn<String>(
      'blur_image', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);

  @override
  List<GeneratedColumn> get $columns =>
      [id, photo, username, numberOfLikes, shadowColor, blurImage];

  @override
  String get aliasedName => _alias ?? actualTableName;

  @override
  String get actualTableName => $name;
  static const String $name = 'cached_photos_table';

  @override
  VerificationContext validateIntegrity(Insertable<CachedPhotosTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('photo')) {
      context.handle(_photoMeta, photo.isAcceptableOrUnknown(data['photo']!, _photoMeta));
    } else if (isInserting) {
      context.missing(_photoMeta);
    }
    if (data.containsKey('username')) {
      context.handle(
          _usernameMeta, username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('number_of_likes')) {
      context.handle(_numberOfLikesMeta,
          numberOfLikes.isAcceptableOrUnknown(data['number_of_likes']!, _numberOfLikesMeta));
    } else if (isInserting) {
      context.missing(_numberOfLikesMeta);
    }
    if (data.containsKey('shadow_color')) {
      context.handle(_shadowColorMeta,
          shadowColor.isAcceptableOrUnknown(data['shadow_color']!, _shadowColorMeta));
    } else if (isInserting) {
      context.missing(_shadowColorMeta);
    }
    if (data.containsKey('blur_image')) {
      context.handle(
          _blurImageMeta, blurImage.isAcceptableOrUnknown(data['blur_image']!, _blurImageMeta));
    } else if (isInserting) {
      context.missing(_blurImageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};

  @override
  CachedPhotosTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedPhotosTableData(
      id: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      photo:
          attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}photo'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      numberOfLikes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}number_of_likes'])!,
      shadowColor: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}shadow_color'])!,
      blurImage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}blur_image'])!,
    );
  }

  @override
  $CachedPhotosTableTable createAlias(String alias) {
    return $CachedPhotosTableTable(attachedDatabase, alias);
  }
}

class CachedPhotosTableData extends DataClass implements Insertable<CachedPhotosTableData> {
  final String id;
  final String photo;
  final String username;
  final int numberOfLikes;
  final int shadowColor;
  final String blurImage;

  const CachedPhotosTableData(
      {required this.id,
      required this.photo,
      required this.username,
      required this.numberOfLikes,
      required this.shadowColor,
      required this.blurImage});

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['photo'] = Variable<String>(photo);
    map['username'] = Variable<String>(username);
    map['number_of_likes'] = Variable<int>(numberOfLikes);
    map['shadow_color'] = Variable<int>(shadowColor);
    map['blur_image'] = Variable<String>(blurImage);
    return map;
  }

  CachedPhotosTableCompanion toCompanion(bool nullToAbsent) {
    return CachedPhotosTableCompanion(
      id: Value(id),
      photo: Value(photo),
      username: Value(username),
      numberOfLikes: Value(numberOfLikes),
      shadowColor: Value(shadowColor),
      blurImage: Value(blurImage),
    );
  }

  factory CachedPhotosTableData.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedPhotosTableData(
      id: serializer.fromJson<String>(json['id']),
      photo: serializer.fromJson<String>(json['photo']),
      username: serializer.fromJson<String>(json['username']),
      numberOfLikes: serializer.fromJson<int>(json['numberOfLikes']),
      shadowColor: serializer.fromJson<int>(json['shadowColor']),
      blurImage: serializer.fromJson<String>(json['blurImage']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'photo': serializer.toJson<String>(photo),
      'username': serializer.toJson<String>(username),
      'numberOfLikes': serializer.toJson<int>(numberOfLikes),
      'shadowColor': serializer.toJson<int>(shadowColor),
      'blurImage': serializer.toJson<String>(blurImage),
    };
  }

  CachedPhotosTableData copyWith(
          {String? id,
          String? photo,
          String? username,
          int? numberOfLikes,
          int? shadowColor,
          String? blurImage}) =>
      CachedPhotosTableData(
        id: id ?? this.id,
        photo: photo ?? this.photo,
        username: username ?? this.username,
        numberOfLikes: numberOfLikes ?? this.numberOfLikes,
        shadowColor: shadowColor ?? this.shadowColor,
        blurImage: blurImage ?? this.blurImage,
      );

  @override
  String toString() {
    return (StringBuffer('CachedPhotosTableData(')
          ..write('id: $id, ')
          ..write('photo: $photo, ')
          ..write('username: $username, ')
          ..write('numberOfLikes: $numberOfLikes, ')
          ..write('shadowColor: $shadowColor, ')
          ..write('blurImage: $blurImage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, photo, username, numberOfLikes, shadowColor, blurImage);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedPhotosTableData &&
          other.id == this.id &&
          other.photo == this.photo &&
          other.username == this.username &&
          other.numberOfLikes == this.numberOfLikes &&
          other.shadowColor == this.shadowColor &&
          other.blurImage == this.blurImage);
}

class CachedPhotosTableCompanion extends UpdateCompanion<CachedPhotosTableData> {
  final Value<String> id;
  final Value<String> photo;
  final Value<String> username;
  final Value<int> numberOfLikes;
  final Value<int> shadowColor;
  final Value<String> blurImage;
  final Value<int> rowid;

  const CachedPhotosTableCompanion({
    this.id = const Value.absent(),
    this.photo = const Value.absent(),
    this.username = const Value.absent(),
    this.numberOfLikes = const Value.absent(),
    this.shadowColor = const Value.absent(),
    this.blurImage = const Value.absent(),
    this.rowid = const Value.absent(),
  });

  CachedPhotosTableCompanion.insert({
    required String id,
    required String photo,
    required String username,
    required int numberOfLikes,
    required int shadowColor,
    required String blurImage,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        photo = Value(photo),
        username = Value(username),
        numberOfLikes = Value(numberOfLikes),
        shadowColor = Value(shadowColor),
        blurImage = Value(blurImage);

  static Insertable<CachedPhotosTableData> custom({
    Expression<String>? id,
    Expression<String>? photo,
    Expression<String>? username,
    Expression<int>? numberOfLikes,
    Expression<int>? shadowColor,
    Expression<String>? blurImage,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (photo != null) 'photo': photo,
      if (username != null) 'username': username,
      if (numberOfLikes != null) 'number_of_likes': numberOfLikes,
      if (shadowColor != null) 'shadow_color': shadowColor,
      if (blurImage != null) 'blur_image': blurImage,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedPhotosTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? photo,
      Value<String>? username,
      Value<int>? numberOfLikes,
      Value<int>? shadowColor,
      Value<String>? blurImage,
      Value<int>? rowid}) {
    return CachedPhotosTableCompanion(
      id: id ?? this.id,
      photo: photo ?? this.photo,
      username: username ?? this.username,
      numberOfLikes: numberOfLikes ?? this.numberOfLikes,
      shadowColor: shadowColor ?? this.shadowColor,
      blurImage: blurImage ?? this.blurImage,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (photo.present) {
      map['photo'] = Variable<String>(photo.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (numberOfLikes.present) {
      map['number_of_likes'] = Variable<int>(numberOfLikes.value);
    }
    if (shadowColor.present) {
      map['shadow_color'] = Variable<int>(shadowColor.value);
    }
    if (blurImage.present) {
      map['blur_image'] = Variable<String>(blurImage.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedPhotosTableCompanion(')
          ..write('id: $id, ')
          ..write('photo: $photo, ')
          ..write('username: $username, ')
          ..write('numberOfLikes: $numberOfLikes, ')
          ..write('shadowColor: $shadowColor, ')
          ..write('blurImage: $blurImage, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final $CachedPhotosTableTable cachedPhotosTable = $CachedPhotosTableTable(this);

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();

  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [cachedPhotosTable];
}
