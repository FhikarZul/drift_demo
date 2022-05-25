import 'package:drift_demo/ui/tambah_kategori_page.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
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
              onPressed: () {},
              child: const Text('Tambah Todo'),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Tampil Todo'),
            ),
          )
        ],
      ),
    );
  }
}
