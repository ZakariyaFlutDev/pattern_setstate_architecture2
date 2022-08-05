import 'package:flutter/material.dart';
import 'package:pattern_setstate_architecture2/pages/create_post.dart';
import 'package:pattern_setstate_architecture2/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        HomePage.id:(context) => HomePage(),
        CreatePost.id:(context) => CreatePost(),
      },
    );
  }
}
