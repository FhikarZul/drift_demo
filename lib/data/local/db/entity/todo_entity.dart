import 'package:drift/drift.dart';
import 'package:drift_demo/data/local/db/entity/kategori_entity.dart';
import 'package:drift_demo/data/local/db/entity/tag_entity.dart';

@DataClassName('TodoModel')
class Todo extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().named('title')();
  TextColumn get content => text().named('content')();
  IntColumn get katId =>
      integer().named('ketegori_id').nullable().references(Categori, #id)();
  IntColumn get tagId =>
      integer().named('tag_id').nullable().references(Tag, #id)();
}
