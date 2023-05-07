import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:recipe_book_client/models/ingredient.dart';
import 'package:recipe_book_client/models/recipe.dart';
import 'package:recipe_book_client/pages/change_recipe_page.dart';
import 'package:recipe_book_client/utils/db_handler.dart';

class RecipeDetailsPage extends StatefulWidget {
  final Recipe currentRecipe;

  const RecipeDetailsPage({super.key, required this.currentRecipe});

  @override
  RecipeDetailsPageState createState() => RecipeDetailsPageState();
}

class RecipeDetailsPageState extends State<RecipeDetailsPage> {
  late List<Ingredient> ingredientsList;

  @override
  void initState() {
    super.initState();

    DBHandler.fetchRecipeIngredients(widget.currentRecipe.id).then((data) => {
          setState(() {
            ingredientsList = data;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.currentRecipe.title)),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ChangeRecipePage(currentRecipe: widget.currentRecipe)));
          },
          child: const Icon(Icons.add)),
    );
  }
}
