import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_demo/data/local/db/entity/todo_entity.dart';
import 'package:drift_demo/data/local/db/model/category_with_item.dart';
import 'package:drift_demo/data/local/db/model/todo_and_tag.dart';
import 'package:drift_demo/data/local/db/model/todo_join.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:rxdart/rxdart.dart';

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
  AppDb(QueryExecutor e) : super(e);

  factory AppDb.createDb() => AppDb(_openConnection());

  @override
  int get schemaVersion => 1;

  //!
  Stream<List<CategoryWithItem>> getCategoryWithItem() {
    final categoryStream = select(categori);

    final todoAndTagQuery =
        select(todo).join([innerJoin(tag, tag.id.equalsExp(todo.tagId))]);

    return categoryStream.watch().switchMap((rows) {
      final idToCat = {for (var cat in rows) cat.id: cat};
      final ids = idToCat.keys;

      return todoAndTagQuery.watch().map((rows) {
        final Map<int, List<TodoAndTag>> idToItemsAndTag = {};

        for (final element in rows) {
          final todoItem = element.readTable(todo);
          final tagItem = element.readTable(tag);

          idToItemsAndTag
              .putIfAbsent(todoItem.katId ?? 0, () => [])
              .add(TodoAndTag(todo: todoItem, tag: tagItem));
        }

        final List<CategoryWithItem> result = [];

        for (var id in ids) {
          result.add(CategoryWithItem(
            categori: idToCat[id]!,
            todoAndTag: idToItemsAndTag[id] ?? [],
          ));
        }

        return result;
      });
    });
  }

  Stream<List<TodoJoin>> getTodos() {
    final query = select(todo).join([
      leftOuterJoin(categori, categori.id.equalsExp(todo.katId)),
      leftOuterJoin(tag, tag.id.equalsExp(todo.tagId))
    ]);

    return query.watch().map(
      (rows) {
        return rows.map((row) {
          return TodoJoin(
            todo: row.readTable(todo),
            categori: row.readTableOrNull(categori),
            tag: row.readTableOrNull(tag),
          );
        }).toList();
      },
    );
  }

  Future<List<CategoriModel>> getCategori() async {
    return await select(categori).get();
  }

  Future<List<TagModel>> getTag() async {
    return await select(tag).get();
  }

  Future<int> insertTodo(TodoCompanion entity) async {
    return await into(todo).insert(entity);
  }

  Future<int> upsertTag(TagCompanion entity) async {
    return await into(tag).insertOnConflictUpdate(entity);
  }

  Future<int> insertCategori(CategoriCompanion entity) async {
    return await into(categori).insert(entity);
  }
}
