import 'package:flutter/material.dart';

import 'package:recipe_book_client/models/ingredient.dart';
import 'package:recipe_book_client/models/recipe.dart';
import 'package:recipe_book_client/utils/db_handler.dart';

class ChangeRecipePage extends StatefulWidget {
  final Recipe currentRecipe;

  const ChangeRecipePage({super.key, required this.currentRecipe});

  @override
  ChangeRecipePageState createState() => ChangeRecipePageState();
}

class ChangeRecipePageState extends State<ChangeRecipePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  Ingredient? _selectedIngredient;
  List<Ingredient> _ingredientsList = [];
  List<Ingredient> outputIngredientsList = [];
  bool _isPublic = false;

  void _addItemToList() {
    outputIngredientsList.add(Ingredient(
        id: _selectedIngredient!.id,
        name: _selectedIngredient!.name,
        weight: weightController.text));
  }

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    weightController = TextEditingController();

    titleController.text = widget.currentRecipe.title;
    descriptionController.text = widget.currentRecipe.description;

    DBHandler.fetchIngredients().then((ingredients) {
      setState(() {
        _ingredientsList = ingredients;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    weightController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change recipe")),
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(5),
              child: Column(children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                  ),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                  ),
                ),
              ])),
          Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(5),
              child: const Text("Ingredients list")),
          Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            child: SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: outputIngredientsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      title: TextField(
                        controller: TextEditingController(
                            text: outputIngredientsList[index].weight),
                        onChanged: (value) {
                          outputIngredientsList[index].weight = value;
                        },
                        decoration: InputDecoration(
                          labelText: outputIngredientsList[index].name,
                        ),
                      ),
                      trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              outputIngredientsList.removeAt(index);
                            });
                          }));
                },
              ),
            ),
          ),
          Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  DropdownButton<Ingredient>(
                      value: _selectedIngredient,
                      hint: const Text("Choose ingredient"),
                      isExpanded: true,
                      items: _ingredientsList.map((Ingredient ingredient) {
                        return DropdownMenuItem<Ingredient>(
                          value: ingredient,
                          child: Text(ingredient.name),
                        );
                      }).toList(),
                      onChanged: (Ingredient? value) {
                        setState(() {
                          _selectedIngredient = value!;
                        });
                      }),
                  TextField(
                    controller: weightController,
                    maxLength: 32,
                    decoration: const InputDecoration(
                      hintText: 'Weight',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _addItemToList,
                    child: const Text('Add to List'),
                  ),
                ],
              )),
          Container(
            padding: const EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width,
            height: 100,
            alignment: Alignment.center,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Published?"),
              Checkbox(
                value: _isPublic,
                onChanged: (value) {
                  setState(() {
                    _isPublic = value!;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Add a recipe'),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
