import 'package:flutter/material.dart';
import 'package:not_sepeti_flutter/utils/DatabaseHelper.dart';

import 'models/Category.dart';

class NoteAddingPage extends StatefulWidget {
  const NoteAddingPage({Key? key}) : super(key: key);

  @override
  State<NoteAddingPage> createState() => _NoteAddingPageState();
}

class _NoteAddingPageState extends State<NoteAddingPage> {

  var db = DatabaseHelper();
  int dropDownValue = 1;
  late List<Category> allCategory = [];
  static var _oncelik = ["Düşük","Orta","Yüksek"];
  String dropDownOncelikValue = _oncelik[0];

@override
  void initState() {
    db.getCategories().then((categoryMap) {
      for(Map category in categoryMap){
        Category c = Category.fromMap(category);
        allCategory.add(c);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Yeni Not"),
      ),
      body: Padding(
          padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Text("Kategori:",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),
                SizedBox(
                  width: 30,
                ),
                allCategory.length<=0 ? CircularProgressIndicator() :
                Container(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        value: dropDownValue,
                        items: kategoriItems(),
                        onChanged: (value){
                          setState(() {
                            dropDownValue = value!;
                          });
                        }
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.redAccent,width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Not başlığını giriniz",
                labelText: "Başlık",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(
              height: 30,
            ),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Not içeriğini giriniz",
                labelText: "İçerik",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(
              height: 30,
            ),
            oncelikDurumu(),
            SizedBox(
              height: 30,
            ),
            buttons(),
          ],
        ),
      ),
    );
  }

    Future<List<Category>> getCategory() async {
      var list = await db.getCategories();
      for(var i in list){
        allCategory.add(Category.fromMap(i));
      }

      return allCategory;
    }
    
    List<DropdownMenuItem> kategoriItems(){
      return allCategory.map((kategori) => DropdownMenuItem(
          value: kategori.categoryID,
          child: Text(kategori.categoryName,style: TextStyle(fontSize: 20),),
      )).toList();
    }

  oncelikDurumu() {
    return Row(
      children: [
        Text("Öncelik:",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),
        SizedBox(
          width: 30,
        ),
        allCategory.length<=0 ? CircularProgressIndicator() :
        Container(
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
                value: dropDownOncelikValue,
                items: _oncelik.map((e){
                  return DropdownMenuItem(value : e,child: Text(e,style: TextStyle(fontSize: 20),));
                }).toList(),
                onChanged: (value){
                  setState(() {
                    dropDownOncelikValue = value!;
                  });
                }
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.redAccent,width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ],
    );
  }

  buttons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
            padding: EdgeInsets.only(left: 8),
          child: TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text("KAYDET",style: TextStyle(fontSize: 25,color: Colors.green),),
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.grey.shade300),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text("VAZGEÇ",style: TextStyle(fontSize: 25,color: Colors.red),),
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.grey.shade300),
            ),
          ),
        ),
      ],
    );
  }

}
