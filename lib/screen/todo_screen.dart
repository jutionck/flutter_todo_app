import 'package:flutter/material.dart';
import 'package:todo_apps/data/db/db_helper.dart';
import 'package:todo_apps/data/db/todo_dao.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final db = DBHelper.instance;
  final keyForm = GlobalKey<FormState>();
  TextEditingController controllerTodoName = TextEditingController();
  String todoName = "";

  @override
  void initState() {
    super.initState();
    db.openDB();
    // db.insert(TodoDao.TABLE_NAME, {
    //   "id": 1,
    //   "name": "Eat"
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo Apps'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(top: 36, left: 24, bottom: 4),
            child:
                Text("Input Todo", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Form(
            key: keyForm,
            child: Container(
              margin: EdgeInsets.only(left: 24, right: 24),
              child: Column(
                children: [
                  TextFormField(
                    controller: controllerTodoName,
                    decoration: InputDecoration(hintText: "Todo Name"),
                    validator: (value) => _onValidateText(value!),
                    keyboardType: TextInputType.text,
                    onSaved: (value) => todoName = value!,
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 24, right: 24),
                child: ElevatedButton(
                  onPressed: () {
                    _onSaveTodo();
                  },
                  child: Text("Simpan"),
                ),
              ),
            ],
          ),
          // Container(
          //   margin: EdgeInsets.only(top: 24, left: 24, bottom: 4),
          //   child: Text("Data Mahasiswa",
          //       style: TextStyle(fontWeight: FontWeight.bold)),
          // ),
          // Expanded(
          //     child: ListView.builder(
          //         itemCount: mahasiswa.length,
          //         padding: EdgeInsets.fromLTRB(24, 0, 24, 8),
          //         itemBuilder: (BuildContext context, int index) {
          //           var value = mahasiswa[index];
          //           return Container(
          //             margin: EdgeInsets.only(bottom: 12),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.stretch,
          //               mainAxisSize: MainAxisSize.min,
          //               children: [
          //                 Text("Nim: ${value.nim}"),
          //                 Text("Name: ${value.name}"),
          //                 Text("Department: ${value.department}"),
          //                 Text("SKS: ${value.sks}"),
          //               ],
          //             ),
          //           );
          //         }))
        ],
      ),
    );
  }

  String? _onValidateText(String value) {
    if (value.isEmpty) return 'Tidak boleh kosong';
    return null;
  }

  _onSaveTodo() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (keyForm.currentState!.validate()) {
      keyForm.currentState!.save();
      controllerTodoName.text = "";
      await db.insert(TodoDao.CREATE_TABLE, {'id': 1, 'name': todoName});
      // mahasiswa = await MySqflite.instance.getMahasiswa();
      print(todoName);
      setState(() {});
    }
  }
}
