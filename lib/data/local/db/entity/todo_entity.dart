import 'package:drift/drift.dart';

@DataClassName('TodoModel')
class Todo extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().named('title')();
  TextColumn get content => text().named('content')();
  // IntColumn get katId => integer().autoIncrement().named('ketegori_id')();
  // IntColumn get tagId => integer().autoIncrement().named('tag_id')();
}
