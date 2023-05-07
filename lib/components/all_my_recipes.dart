import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:recipe_book_client/models/recipe.dart';
import 'package:recipe_book_client/pages/recipe_details_page.dart';

import '../pages/add_recipe_page.dart';

class AllMyRecipes extends StatefulWidget {
  const AllMyRecipes({super.key});

  @override
  AllMyRecipesState createState() => AllMyRecipesState();
}

class AllMyRecipesState extends State<AllMyRecipes> {
  late List<Recipe> _recipes = [];

  Future<List<Recipe>> fetchRecipes() async {
    final response =
        await http.get(Uri.parse('http://localhost:5000/recipes/${1}'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;

      return data.map((item) {
        return Recipe(
            id: item['id'],
            title: item['title'],
            description: item['description'],
            ownerId: item['owner_id'],
            isPublic: item['is_public']);
      }).toList();
    } else {
      throw Exception('Failed to fetch recipes');
    }
  }

  @override
  void initState() {
    super.initState();

    fetchRecipes().then((recipes) {
      setState(() {
        _recipes = recipes;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _recipes.length,
        itemBuilder: (context, index) {
          final recipe = _recipes[index];
          return ListTile(
              title: Text(recipe.title),
              subtitle: Text(recipe.description),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            RecipeDetailsPage(currentRecipe: recipe)));
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddRecipePage()));
          },
          child: const Icon(Icons.add)),
    );
  }
}
