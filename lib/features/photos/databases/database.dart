import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_template/features/photos/databases/tables/cached_photos_table.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

/// Database.
@DriftDatabase(
  tables: [CachedPhotosTable],
)
class Database extends _$Database {
  /// Create an instance Database.
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(path.join(dbFolder.path, 'db.sqjite'));
      return NativeDatabase(file);
    });
  }
}
