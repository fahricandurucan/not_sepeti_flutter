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
                  width: 50,
                ),

                allCategory.length<=0 ? CircularProgressIndicator() :
                DropdownButton(
                    value: dropDownValue,
                    items: kategoriItems(),
                    onChanged: (value){
                      setState(() {
                        dropDownValue = value!;
                      });
                    }
                ),
              ],
            ),
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
          child: Text(kategori.categoryName),
      )).toList();
    }

}
