import 'package:drift/native.dart';
import 'package:drift_demo/data/local/db/app_db.dart';
import 'package:drift_demo/ui/tambah_kategori_page.dart';
import 'package:drift_demo/ui/view_todo_page.dart';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;

import 'tambah_todo_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  AppDb? appDb;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    appDb = AppDb(NativeDatabase.memory());
    const entity = TagCompanion(
      id: drift.Value(1),
      name: drift.Value('Tag 1'),
    );

    appDb!.upsertTag(entity);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    appDb!.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TambahKategoriPage()),
                );
              },
              child: const Text('Tambah Kategori'),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TambahTodoPage()),
                );
              },
              child: const Text('Tambah Todo'),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ViewTodoPage()),
                );
              },
              child: const Text('Tampil Todo'),
            ),
          )
        ],
      ),
    );
  }
}
