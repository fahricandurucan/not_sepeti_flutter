import 'package:flutter/material.dart';
import 'package:not_sepeti_flutter/utils/DatabaseHelper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    var db = DatabaseHelper();
    db.getCategories();
    return Scaffold(
      appBar: AppBar(
        title: Text("Not Sepeti"),
      ),
      body: Center(
        child: Text("Hello")
      ),
    );
  }
}
