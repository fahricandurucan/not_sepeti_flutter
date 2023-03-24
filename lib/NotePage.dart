import 'package:flutter/material.dart';
import 'package:not_sepeti_flutter/models/Category.dart';
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
                kategoriEkle();
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


  void kategoriEkle() {
    var formKey = GlobalKey<FormState>();
    late String yeniKategoriAd;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context){
          return SimpleDialog(
            title: Text("Kategori Ekle"),
            children: [
              Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: TextFormField(
                    onSaved: (value){
                      yeniKategoriAd = value!;
                    },
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
              ),

              ButtonBar(
                children: [
                  TextButton(
                    onPressed: (){
                      if(formKey.currentState!.validate()){
                        formKey.currentState?.save();
                        db.addCategory(Category(yeniKategoriAd)).then((value){
                          if(value>0){
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Kategori eklendi!",),
                                  duration:Duration(seconds: 2),));
                          }
                          Navigator.pop(context);
                        });

                      }
                    },
                    child: Text("Kaydet",style: TextStyle(color: Colors.green,fontSize: 18),),

                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: Text("Vazgeç",style: TextStyle(color: Colors.red,fontSize: 18)),
                  ),
                ],
              ),
            ],
          );
        }
    );
  }
}
