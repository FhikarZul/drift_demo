import 'package:drift/drift.dart';

@DataClassName('CategoriModel')
class Categori extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().named('name')();
}
