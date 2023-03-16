
class Category{
  late int categoryID;
  late String categoryName;

  Category(this.categoryName); // kategori eklerken kullan çünkü id otomatik veriliyor
  Category.withID(this.categoryID,this.categoryName); //kategorileri okurken

  Map<String,dynamic> toMap(){
    var map = Map<String,dynamic>();
    map["categoryID"] = categoryID;
    map["categoryName"] = categoryName;
    return map;
  }
  Category.fromMap(Map<String,dynamic> map){
    this.categoryID = map["categoryID"];
    this.categoryName = map["categoryName"];
  }

  @override
  String toString() {
    return 'Category{categoryID: $categoryID, categoryName: $categoryName}';
  }
}