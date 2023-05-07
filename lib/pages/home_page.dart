import 'package:flutter/material.dart';
import 'package:recipe_book_client/components/all_public_recipes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const AllPublicRecipes();
  }
}
