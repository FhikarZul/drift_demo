import 'package:drift/drift.dart';

@DataClassName('TagModel')
class Tag extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}
