import 'package:drift_demo/data/local/db/app_db.dart';
import 'package:equatable/equatable.dart';

class TodoAndTag extends Equatable {
  final TodoModel? todo;
  final TagModel? tag;

  TodoAndTag({
    required this.todo,
    required this.tag,
  });

  @override
  List<Object?> get props => [todo, tag];
}
