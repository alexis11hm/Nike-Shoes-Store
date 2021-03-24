import 'package:flutter/material.dart';
import 'package:nike_shoes_store/src/pages/details_page.dart';
import 'package:nike_shoes_store/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'details': (BuildContext context) => DetailsPage()
      },
    );
  }
}
