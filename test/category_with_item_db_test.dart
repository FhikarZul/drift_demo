import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_demo/data/local/db/app_db.dart';
import 'package:drift_demo/data/local/db/entity/tag_entity.dart';
import 'package:drift_demo/data/local/db/model/category_with_item.dart';
import 'package:drift_demo/data/local/db/model/todo_and_tag.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDb db;

  setUp(() {
    db = AppDb(NativeDatabase.memory());
  });

  tearDown(() async => await db.close());

  final dummyTag = TagCompanion(
    id: Value(1),
    name: Value('lorem tag'),
  );
  final dummyCategory = CategoriCompanion(
    id: Value(1),
    name: Value('lorem category'),
  );
  final dummyCategory2 = dummyCategory.copyWith(
    id: Value(2),
  );
  final dummyTodo = TodoCompanion(
    id: Value(1),
    content: Value('Lorem Ipsum'),
    title: Value('Lorem Ipsum'),
    katId: Value(1),
    tagId: Value(1),
  );
  final dummyTodo2 = dummyTodo.copyWith(
    id: Value(2),
    katId: Value(2),
  );

  final dummyResultTag = TagModel(id: 1, name: 'lorem tag');
  final dummyResultCategory1 = CategoriModel(id: 1, name: 'lorem category');
  final dummyResultCategory2 = dummyResultCategory1.copyWith(id: 2);
  final dummyResultTodo1 = TodoModel(
    id: 1,
    title: 'Lorem Ipsum',
    content: 'Lorem Ipsum',
    katId: 1,
    tagId: 1,
  );
  final dummyResultTodo2 = dummyResultTodo1.copyWith(
    id: 2,
    katId: 2,
  );

  test('should return all category with item', () async {
    await db.insertCategori(dummyCategory);
    await db.insertCategori(dummyCategory2);

    await db.into(db.tag).insert(dummyTag);

    await db.insertTodo(dummyTodo);
    await db.insertTodo(dummyTodo2);

    final result = await db.getCategoryWithItem().first;

    expect(result, [
      CategoryWithItem(
        categori: dummyResultCategory1,
        todoAndTag: [TodoAndTag(todo: dummyResultTodo1, tag: dummyResultTag)],
      ),
      CategoryWithItem(
        categori: dummyResultCategory2,
        todoAndTag: [TodoAndTag(todo: dummyResultTodo2, tag: dummyResultTag)],
      ),
    ]);
  });
}
