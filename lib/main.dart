import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stylecart/providers/cartprovider.dart';
import 'package:stylecart/providers/providerrr.dart';
import 'screens/detailed page.dart';
import 'screens/homescreen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ProductProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => CartProvider(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {"DetailPage": (context) => DetailedPage()},
      home: HomePage(),
    );
  }
}
