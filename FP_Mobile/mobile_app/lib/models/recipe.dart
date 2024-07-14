class Recipe {
  final String? id;
  final String name;
  final List<String> ingredients;
  final String instructions;

  Recipe({
    this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
  });

  factory Recipe.fromJson(Map<String, dynamic> json, String id) {
    return Recipe(
      id: id,
      name: json['name'],
      ingredients: List<String>.from(json['ingredients']),
      instructions: json['instructions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'ingredients': ingredients,
      'instructions': instructions,
    };
  }
}
