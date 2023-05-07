import 'package:flutter/material.dart';
import 'package:recipe_book_client/pages/home_page.dart';
import 'package:recipe_book_client/pages/main_view.dart';
import 'package:recipe_book_client/pages/my_recipe_page.dart';

void main() {
  runApp(MaterialApp(
    title: 'Recipe Book',
    initialRoute: "/",
    routes: {
      "/": (context) => const MainPage(),
      "/home": (context) => const HomePage(),
      "/my-recipes": (context) => const MyRecipePage(),
    },
    debugShowCheckedModeBanner: false,
  ));
}
