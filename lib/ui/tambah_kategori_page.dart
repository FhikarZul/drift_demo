import 'package:drift/drift.dart' as drift;
import 'package:drift_demo/data/local/db/app_db.dart';
import 'package:flutter/material.dart';

class TambahKategoriPage extends StatefulWidget {
  const TambahKategoriPage({Key? key}) : super(key: key);

  @override
  State<TambahKategoriPage> createState() => _TambahKategoriPageState();
}

class _TambahKategoriPageState extends State<TambahKategoriPage> {
  TextEditingController controller = TextEditingController();
  AppDb? appDb;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appDb = AppDb();
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
              title: const Text("Data Profil")),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: controller,
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
                width: double.infinity,
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () {
                    final entity = CategoriCompanion(
                      name: drift.Value(controller.text),
                    );

                    appDb!.insertCategori(entity).then((value) {
                      print('Berhasil');
                    });
                  },
                  child: const Text('Simpan'),
                ),
              )
            ],
          )),
    );
  }
}
