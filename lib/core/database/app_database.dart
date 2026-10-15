import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../utils/enums.dart';
import 'daos/memories_dao.dart';
import 'tables/attachments.dart';
import 'tables/memories.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Memories, Attachments],
  daos: [MemoriesDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? driftDatabase(name: 'memory_reminder'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    beforeOpen: (details) async {
      // Required for ON DELETE CASCADE to work in SQLite.
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
