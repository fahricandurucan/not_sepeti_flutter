import 'package:flutter/material.dart';
import 'package:not_sepeti_flutter/utils/DatabaseHelper.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  var db = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Not Sepeti"),
      ),
      body: FutureBuilder(
          future: db.getCategories(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              var noteList = snapshot.data;
              return ListView(
                children: [
                  for(var noteMap in noteList!)
                    ListTile(
                      leading: CircleAvatar(),
                      title:Text(noteMap["categoryName"]),
                      trailing: Icon(Icons.arrow_drop_down),
                    ),
                ],
              );
            }
            else{
              return Text("afda");
            }
          }
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              onPressed: (){
                showDialog(
                  barrierDismissible: false,
                    context: context,
                    builder: (context){
                      return SimpleDialog(
                        title: Text("Kategori Ekle"),
                        children: [
                          Padding(
                              padding: EdgeInsets.all(12),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  labelText: "Kategori Adı",
                                  border: OutlineInputBorder(),
                              ),
                              validator: (value){
                                if(value!.length<3){
                                  return "en az 3 karakter giriniz";
                                }
                              },
                            ),
                          ),

                          ButtonBar(
                            children: [
                              TextButton(
                                  onPressed: (){},
                                  child: Text("Kaydet"),
                              ),
                              TextButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  child: Text("Vazgeç"),
                              ),
                            ],
                          ),
                        ],
                      );
                    }

                );
              },
            child: Icon(Icons.menu_book),
            backgroundColor: Colors.pink,
            mini: true,
          ),
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: (){

            },
            backgroundColor: Colors.pink,
          ),
        ],
      ),

    );
  }
}
