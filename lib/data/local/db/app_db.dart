import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_demo/data/local/db/entity/todo_entity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import 'entity/kategori_entity.dart';
import 'entity/tag_entity.dart';

part 'app_db.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'driftdemo.sqlite'));

    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [Categori, Tag, Todo])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<TodoModel>> getTodos() async {
    return await select(todo).get();
  }

  Future<int> insertTodo(TodoCompanion entity) async {
    return await into(todo).insert(entity);
  }

  Future<int> insertTag(TagCompanion entity) async {
    return await into(tag).insert(entity);
  }

  Future<int> insertCategori(CategoriCompanion entity) async {
    return await into(categori).insert(entity);
  }
}
