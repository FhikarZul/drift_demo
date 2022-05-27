import 'package:drift_demo/data/local/db/app_db.dart';
import 'package:drift_demo/data/local/db/model/todo_join.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ViewTodoPage extends StatefulWidget {
  const ViewTodoPage({Key? key}) : super(key: key);

  @override
  State<ViewTodoPage> createState() => _ViewTodoPageState();
}

class _ViewTodoPageState extends State<ViewTodoPage> {
  AppDb? appDb;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appDb = AppDb();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
          title: const Text("View Todo"),
        ),
        body: StreamBuilder<List<TodoJoin>>(
          stream: appDb!.getTodos(),
          builder: (context, snapshot) {
            final List<TodoJoin> list = snapshot.data!;
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final data = list[index];
                  return SizedBox(
                    width: double.infinity,
                    child: Card(
                        child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text('Title: ${data.todo!.title}'),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text('Content: ${data.todo!.content}'),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text('Kategori: ${data.categori!.name}'),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text('Tag: ${data.tag!.name}'),
                          ),
                        ],
                      ),
                    )),
                  );
                },
              );
            }

            return const Text('No data');
          },
        ),
      ),
    );
  }
}
