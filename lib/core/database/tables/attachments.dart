import 'package:drift/drift.dart';

import '../../utils/enums.dart';
import 'memories.dart';

class Attachments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get memoryId => integer().references(Memories, #id, onDelete: KeyAction.cascade)();
  TextColumn get type => textEnum<AttachmentType>()();
  IntColumn get sizeBytes => integer().withDefault(const Constant(0))();
  TextColumn get relativePath => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
