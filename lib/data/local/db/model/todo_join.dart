import 'package:drift_demo/data/local/db/app_db.dart';

class TodoJoin {
  final TodoModel? todo;
  final CategoriModel? categori;
  final TagModel? tag;

  TodoJoin({
    required this.todo,
    required this.categori,
    required this.tag,
  });
}
