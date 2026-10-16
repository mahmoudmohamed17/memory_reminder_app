import 'package:drift/drift.dart';

import '../../utils/enums.dart';
import '../app_database.dart';
import '../tables/attachments.dart';
import '../tables/memories.dart';

part 'memories_dao.g.dart';

/// A memory row together with its children.
class MemoryWithDetails {
  final Memory memory;
  final List<Attachment> attachments;

  new({required this.memory, required this.attachments});
}

class _Acc {
  _Acc(this.memory);

  final Memory memory;
  final Map<int, Attachment> attachments = {};
}

@DriftAccessor(tables: [Memories, Attachments])
class MemoriesDao extends DatabaseAccessor<AppDatabase> with _$MemoriesDaoMixin {
  new(super.db);

  // ───────────────────────── Reads ─────────────────────────
  Stream<List<MemoryWithDetails>> watchAll({
    MemoryCategory? category,
    String normalizedQuery = '',
  }) {
    final filters = <Expression<bool>>[
      if (category != null) memories.category.equalsValue(category),
      if (normalizedQuery.isNotEmpty) memories.normalizedText.contains(normalizedQuery),
    ];
    return _watchJoined(filters);
  }

   Stream<MemoryWithDetails?> watchOne(int id) {
    return _watchJoined([memories.id.equals(id)])
        .map((list) => list.isEmpty ? null : list.first);
  }

  Stream<List<MemoryWithDetails>> _watchJoined(List<Expression<bool>> filters) {
    final query = select(memories).join([
      leftOuterJoin(attachments, attachments.memoryId.equalsExp(memories.id)),
    ]);
    if (filters.isNotEmpty) {
      query.where(filters.reduce((a, b) => a & b));
    }
    query.orderBy([OrderingTerm.desc(memories.updatedAt)]);
    return query.watch().map(_group);
  }

  List<MemoryWithDetails> _group(List<TypedResult> rows) {
    final map = <int, _Acc>{}; // insertion order = query order

    for (final row in rows) {
      final memory = row.readTable(memories);
      final acc = map.putIfAbsent(memory.id, () => _Acc(memory));
      final attachment = row.readTableOrNull(attachments);
      if (attachment != null) acc.attachments[attachment.id] = attachment;
    }
    return [
      for (final a in map.values) MemoryWithDetails(memory: a.memory, attachments: a.attachments.values.toList()),
    ];
  }

  // ───────────────────────── Memories ─────────────────────────
  Future<int> insertMemory(MemoriesCompanion entry) => into(memories).insert(entry);

  Future<void> updateMemory(int id, MemoriesCompanion change) =>
      (update(memories)..where((m) => m.id.equals(id))).write(change);

  Future<List<String>> deleteMemorry(int id) {
    return transaction(() async {
      final paths =
          (select(attachments)..where(
                (a) => a.memoryId.equals(id),
              ))
              .map((a) => a.relativePath)
              .get();
      await (delete(memories)..where((m) => m.id.equals(id))).go();
      return paths;
    });
  }

  // ───────────────────────── Attachments ─────────────────────────
  Future<int> insertAttachment(AttachmentsCompanion entry) {
    return transaction(() async {
      final id = into(attachments).insert(entry);
      await _touch(entry.memoryId.value);
      return id;
    });
  }

  /// Returns the removed file's relative path (or null if not found).
  Future<String?> deleteAttachment(int id) {
    return transaction(() async {
      final row = await (select(attachments)..where((a) => a.id.equals(id))).getSingleOrNull();
      if (row == null) return null;

      await (delete(attachments)..where((a) => a.id.equals(id))).go();
      await _touch(row.memoryId);
      return row.relativePath;
    });
  }

  // ───────────────────────── Helpers ─────────────────────────

  Future<void> _touch(int memoryId) => updateMemory(
    memoryId,
    MemoriesCompanion(updatedAt: Value(DateTime.now())),
  );
}
