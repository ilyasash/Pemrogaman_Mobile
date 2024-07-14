import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart'; 
import '../components/recept_card.dart';
import '../components/image_place.dart';
import '../components/namestyle.dart';
import '../components/dialog.dart';
import '../data/sample_data.dart';
import '../screens/recipe_form_screen.dart';
import '../services/api_services.dart';
import '../models/recipe.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late Future<List<Recipe>> _recipes;
  Flushbar? _flushbar; // Add this line

  @override
  void initState() {
    super.initState();
    _fetchRecipes();
  }

  void _fetchRecipes() {
    setState(() {
      _recipes = ApiService().fetchRecipes();
    });
  }

  void _showDialog(BuildContext context, {String? title, String? msg}) {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        title: title ?? '',
        message: msg ?? '',
        buttonText: 'Close',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showFlushbar(BuildContext context, String message) {
    _flushbar?.dismiss(); // Dismiss previous flushbar if any

    _flushbar = Flushbar(
      message: message,
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(8),
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(10),
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.blue[300],
      ),
      backgroundColor: Colors.black87,
      boxShadows: [
        BoxShadow(
          color: Colors.black38,
          offset: Offset(0.0, 3.0),
          blurRadius: 3.0,
        ),
      ],
    )..show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Sahur'),
      ),
      body: SingleChildScrollView( // Add SingleChildScrollView here
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: 'chef_image',
              child: InkWell(
                onTap: () {
                  _showDialog(
                    context,
                    title: 'Menu Hemat Sahur',
                    msg: 'Bagi Mahasiswa yang mau hemat lets cook with me',
                  );
                },
                child: ImagePlaceView(
                  imageUrl: 'assets/chef_yasa.png',
                  size: 200,
                  onPressed: () {},
                ),
              ),
            ),
            NameStyle(
              text: 'Menu Sahur',
              fontSize: 30.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            TitleText(
              text: 'By chef Maulana Ilyasa',
              fontSize: 20.0,
              color: Color.fromARGB(255, 33, 144, 255),
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 20,
              width: 200,
              child: Divider(
                color: Colors.white,
              ),
            ),
            // Displaying sample data
            ...sampleRecipes.map((recipe) => ReceptCard(
              text: recipe['name'] as String,
              onPressed: () {
                _showDialog(
                  context,
                  title: recipe['name'] as String,
                  msg: 'Ingredients: ${(recipe['ingredients'] as List<String>).join(", ")}\n\nInstructions: ${recipe['instructions'] as String}',
                );
              },
              onEdit: () {
                _showDialog(
                  context,
                  title: 'Sample Data',
                  msg: 'Sample data cannot be edited.',
                );
              },
              onDelete: () {
                _showDialog(
                  context,
                  title: 'Sample Data',
                  msg: 'Sample data cannot be deleted.',
                );
              },
            )),
            FutureBuilder<List<Recipe>>(
              future: _recipes,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No recipes available.'));
                }

                return ListView.builder(
                  shrinkWrap: true, // Add this to shrink the ListView
                  physics: NeverScrollableScrollPhysics(), // Disable ListView scrolling
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final recipe = snapshot.data![index];
                    return ReceptCard(
                      text: recipe.name,
                      onPressed: () {
                        _showDialog(
                          context,
                          title: recipe.name,
                          msg: 'Ingredients: ${recipe.ingredients.join(", ")}\n\nInstructions: ${recipe.instructions}',
                        );
                      },
                      onEdit: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeFormScreen(recipe: recipe, id: recipe.id),
                          ),
                        );
                        _fetchRecipes(); // Refresh the recipes after editing
                        _showFlushbar(context, 'Recipe edited successfully');
                      },
                      onDelete: () async {
                        await ApiService().deleteRecipe(recipe.id!);
                        _fetchRecipes(); // Refresh the recipes after deleting
                        _showFlushbar(context, 'Recipe deleted successfully');
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeFormScreen(),
            ),
          );
          _fetchRecipes(); // Refresh the recipes after adding a new one
          _showFlushbar(context, 'Recipe added successfully');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
