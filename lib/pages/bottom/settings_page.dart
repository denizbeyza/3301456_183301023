import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_keep/models/recipe.dart';
import 'package:recipe_keep/services/recipes/recipe_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final RecipesService _service = RecipesService();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () async {
              // firestore
              //     .collection('recipes')
              //     .doc('1')
              //     .get()
              //     .then((DocumentSnapshot ds) async {
              //   print(Recipe.fromJson(ds.data()).title);
              // });
              bool status = await _service.addRecipe(Recipe(
                  title: "Ispanak",
                  cookingTime: 15,
                  directions: "directions",
                  ingredients: "ingredients",
                  notes: "notes",
                  photo: "",
                  preparationTime: 3));
              print(status ? "============success" : "===============error");
            },
            child: const Text("recipe ekle")),
            
      ],
    );
  }
}
