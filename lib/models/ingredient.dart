class Ingredient {
  late int id;
  late String name;
  late String? weight;

  Ingredient.withoutArguments();
  Ingredient.withoutId({required this.name});
  Ingredient.withoutWeight({required this.id, required this.name});
  Ingredient({required this.id, required this.name, required this.weight});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
        id: json['id'], name: json['name'], weight: json['weight']);
  }
}
