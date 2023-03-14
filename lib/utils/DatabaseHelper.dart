import 'package:sqflite/sqflite.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

class DatabaseHelper{

  static  DatabaseHelper? _databaseHelper;
  static  Database? _database;

  factory DatabaseHelper(){
    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper._internal();
      return _databaseHelper!;
    }
    else{
      return _databaseHelper!;
    }
  }

  DatabaseHelper._internal();

    Future<Database> getDatabase() async {
    if(_database==null){
      _database = await _initializeDatabase();
      return _database!;
    }
    else{
      return _database!;
    }
  }

  _initializeDatabase() async{

    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "demo.db");

// Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "notes.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);

    } else {
      print("Opening existing database");
    }

// open the database
    return await openDatabase(path, readOnly: false);

  }

  getCategories() async{
      var db = await getDatabase();
      var sonuc = await db.query("category");  //return map
      print(sonuc);
  }
}