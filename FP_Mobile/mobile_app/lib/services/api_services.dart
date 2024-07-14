import 'package:firebase_database/firebase_database.dart';
import '../models/recipe.dart';

class ApiService {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  Future<void> createRecipe(Recipe recipe) async {
    await _databaseReference.child('recipes').push().set(recipe.toJson());
  }

  Future<List<Recipe>> fetchRecipes() async {
    DatabaseEvent event = await _databaseReference.child('recipes').once();
    DataSnapshot snapshot = event.snapshot;
    List<Recipe> recipes = [];

    if (snapshot.value != null) {
      Map<dynamic, dynamic> map = snapshot.value as Map<dynamic, dynamic>;
      map.forEach((key, value) {
        recipes.add(Recipe.fromJson(Map<String, dynamic>.from(value), key));
      });
    }

    return recipes;
  }

  Future<void> updateRecipe(String id, Recipe recipe) async {
    await _databaseReference.child('recipes').child(id).set(recipe.toJson());
  }

  Future<void> deleteRecipe(String id) async {
    await _databaseReference.child('recipes').child(id).remove();
  }
}
