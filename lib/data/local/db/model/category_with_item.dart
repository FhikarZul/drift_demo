import 'package:drift_demo/data/local/db/app_db.dart';
import 'package:drift_demo/data/local/db/model/todo_and_tag.dart';
import 'package:equatable/equatable.dart';

class CategoryWithItem extends Equatable {
  final CategoriModel categori;
  final List<TodoAndTag> todoAndTag;

  CategoryWithItem({
    required this.categori,
    required this.todoAndTag,
  });

  @override
  List<Object?> get props => [categori, todoAndTag];
}
