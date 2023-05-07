import 'package:flutter/material.dart';
import 'package:recipe_book_client/components/all_my_recipes.dart';

class MyRecipePage extends StatefulWidget {
  const MyRecipePage({super.key});

  @override
  MyRecipePageState createState() => MyRecipePageState();
}

class MyRecipePageState extends State<MyRecipePage> {
  @override
  Widget build(BuildContext context) {
    return const AllMyRecipes();
  }
}
