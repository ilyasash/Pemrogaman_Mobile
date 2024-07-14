import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/api_services.dart';

class RecipeFormScreen extends StatefulWidget {
  final Recipe? recipe;
  final String? id;

  RecipeFormScreen({this.recipe, this.id});

  @override
  _RecipeFormScreenState createState() => _RecipeFormScreenState();
}

class _RecipeFormScreenState extends State<RecipeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  List<String> _ingredients = [];
  String _instructions = '';

  @override
  void initState() {
    super.initState();
    if (widget.recipe != null) {
      _name = widget.recipe!.name;
      _ingredients = widget.recipe!.ingredients;
      _instructions = widget.recipe!.instructions;
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe == null ? 'Add Recipe' : 'Edit Recipe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Recipe Name'),
                onSaved: (value) {
                  _name = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the recipe name';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _ingredients.join(', '),
                decoration: InputDecoration(labelText: 'Ingredients (comma separated)'),
                onSaved: (value) {
                  _ingredients = value!.split(',').map((e) => e.trim()).toList();
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the ingredients';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _instructions,
                decoration: InputDecoration(labelText: 'Instructions'),
                onSaved: (value) {
                  _instructions = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the instructions';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (widget.recipe == null) {
                      ApiService().createRecipe(Recipe(
                        name: _name,
                        ingredients: _ingredients,
                        instructions: _instructions,
                      ));
                      _showSnackBar(context, 'Recipe added successfully');
                    } else {
                      ApiService().updateRecipe(widget.id!, Recipe(
                        name: _name,
                        ingredients: _ingredients,
                        instructions: _instructions,
                      ));
                      _showSnackBar(context, 'Recipe updated successfully');
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.recipe == null ? 'Add Recipe' : 'Edit Recipe'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
