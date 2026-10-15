// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memories_dao.dart';

// ignore_for_file: type=lint
mixin _$MemoriesDaoMixin on DatabaseAccessor<AppDatabase> {
  $MemoriesTable get memories => attachedDatabase.memories;
  $AttachmentsTable get attachments => attachedDatabase.attachments;
  MemoriesDaoManager get managers => MemoriesDaoManager(this);
}

class MemoriesDaoManager {
  final _$MemoriesDaoMixin _db;
  MemoriesDaoManager(this._db);
  $$MemoriesTableTableManager get memories =>
      $$MemoriesTableTableManager(_db.attachedDatabase, _db.memories);
  $$AttachmentsTableTableManager get attachments =>
      $$AttachmentsTableTableManager(_db.attachedDatabase, _db.attachments);
}
