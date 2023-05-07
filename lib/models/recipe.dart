class Recipe {
  late int id;
  late String title;
  late String description;
  late int ownerId;
  late bool isPublic;

  Recipe(
      {required this.id,
      required this.title,
      required this.description,
      required this.ownerId,
      required this.isPublic});
}
