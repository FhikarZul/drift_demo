import 'package:drift_demo/data/local/db/app_db.dart';
import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;

class TambahTodoPage extends StatefulWidget {
  const TambahTodoPage({Key? key}) : super(key: key);

  @override
  State<TambahTodoPage> createState() => _TambahTodoPageState();
}

class _TambahTodoPageState extends State<TambahTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  AppDb? appDb;
  int? idCategory;
  int? idTag;

  @override
  void initState() {
    super.initState();
    appDb = AppDb();
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
    appDb!.close();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              leading: InkResponse(
                child: const Icon(
                  Icons.arrow_back_outlined,
                  size: 35,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text("Todo")),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Title",
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      fillColor: Colors.white70,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Content",
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: contentController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      fillColor: Colors.white70,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Kategori",
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: FutureBuilder<List<CategoriModel>>(
                    future: appDb!.getCategori(),
                    builder: (context, snapshot) {
                      final List<CategoriModel> categori = snapshot.data!;

                      return _dropDownKategori(categori);
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Tag",
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: FutureBuilder<List<TagModel>>(
                    future: appDb!.getTag(),
                    builder: (context, snapshot) {
                      final List<TagModel> tag = snapshot.data!;

                      return _dropDownTag(tag);
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      final entity = TodoCompanion(
                        title: drift.Value(titleController.text),
                        content: drift.Value(contentController.text),
                        katId: drift.Value(idCategory),
                        tagId: drift.Value(idTag),
                      );

                      appDb!.insertTodo(entity).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('Berhasil'),
                          duration: const Duration(seconds: 1),
                          action: SnackBarAction(
                            label: 'Close',
                            onPressed: () {},
                          ),
                        ));
                      });
                    },
                    child: const Text('Simpan'),
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget _dropDownKategori(List<CategoriModel> item) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        hintStyle: TextStyle(color: Colors.grey[800]),
        fillColor: Colors.white70,
      ),
      hint: const Text("Kategori"),
      isExpanded: true,
      items: item.map((data) {
        return DropdownMenuItem(
          value: data.id,
          child: Text(data.name),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          idCategory = int.parse(value.toString());
          print('Id Kat: ' + value.toString());
        });
      },
    );
  }

  Widget _dropDownTag(List<TagModel> item) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        hintStyle: TextStyle(color: Colors.grey[800]),
        fillColor: Colors.white70,
      ),
      hint: const Text("Tag"),
      isExpanded: true,
      items: item.map((data) {
        return DropdownMenuItem(
          value: data.id,
          child: Text(data.name),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          idTag = int.parse(value.toString());

          print('Id Tag: ' + value.toString());
        });
      },
    );
  }
}
