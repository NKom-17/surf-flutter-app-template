import 'package:drift/drift.dart';

/// Table for the cached photos database.
class CachedPhotosTable extends Table {
  @override
  Set<Column> get primaryKey => <TextColumn>{id};

  /// Photo id.
  TextColumn get id => text()();

  /// Image.
  TextColumn get photo => text()();

  /// The author of the photo.
  TextColumn get username => text()();

  /// The number of likes of the photo.
  IntColumn get numberOfLikes => integer()();

  /// Shadow color of the photo.
  IntColumn get shadowColor => integer()();

  /// Blur when uploading a photo.
  TextColumn get blurImage => text()();
}
