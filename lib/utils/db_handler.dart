import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:recipe_book_client/models/ingredient.dart';
import 'package:recipe_book_client/models/recipe.dart';

class DBHandler {
  // GET
  static Future<List<Ingredient>> fetchIngredients() async {
    final response = await http.get(Uri.http('localhost:5000', 'ingredients'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;

      return data.map((json) => Ingredient.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch ingredients');
    }
  }

  static Future<List<Ingredient>> fetchRecipeIngredients(int recipeId) async {
    final response = await http
        .get(Uri.http('localhost:5000', 'recipes/$recipeId/ingredients'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;

      return data.map((json) => Ingredient.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch ingredients');
    }
  }

  // POST
  Future<http.Response> postRecipe(List<Ingredient> outputIngredientsList,
      String title, String description, bool isPublic) {
    List<int> ingredientsId =
        outputIngredientsList.map((ingredient) => ingredient.id).toList();
    List<String?> ingredientsWeights =
        outputIngredientsList.map((ingredient) => ingredient.weight).toList();

    return http.post(
      Uri.http('localhost:5000', 'recipe'),
      headers: <String, String>{
        "Access-Control-Allow-Origin": "*",
        'Content-Type': 'application/json',
        'Accept': '*/*',
      },
      body: jsonEncode({
        'title': title,
        'description': description,
        'is_public': isPublic,
        'owner_id': 1,
        'ingredientsId': ingredientsId,
        'weights': ingredientsWeights
      }),
    );
  }
}
