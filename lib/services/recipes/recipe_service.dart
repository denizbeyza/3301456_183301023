import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:recipe_keep/models/recipe.dart';

class RecipesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> addRecipe(Recipe recipe, File? image) async {
    try {
      var reference = FirebaseStorage.instance
          .ref()
          .child("images")
          .child(DateTime.now().toString());
      if (image != null) {
        await reference.putFile(image);
        String url = await reference.getDownloadURL();
        recipe.photo = url;
      }

      _firestore.collection('recipes').add(recipe.toJson()).then((value) async {
        var user = await _firestore
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .get();
        var userData = user.data();
        List<dynamic> recipes = userData!["recipes"];
        recipes.add(value.id);
        _firestore
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .update({"recipes": recipes});
      });
      return true;
    } catch (_) {
      return false;
    }
  }

  _getUserRecipesId() async {
    try {
      var doc = await _firestore
          .collection("users")
          .where("id", isEqualTo: _auth.currentUser!.uid)
          .get();
      var data = doc.docs[0].data();
      List<String> recipesId = [];
      for (var i in data["recipes"]) {
        recipesId.add(i);
      }
      return recipesId;
    } catch (e) {
      print("==================hata");
    }
  }

  Future<List<Recipe>> getRecipes() async {
    List<String> recipesId = await _getUserRecipesId();
    List<Recipe> recipes = [];
    for (var i in recipesId) {
      var recipe = await _firestore.doc("recipes/" + i).get();
      recipes.add(Recipe(
          title: recipe.data()!["title"],
          cookingTime: recipe.data()!["cooking_time"],
          preparationTime: recipe.data()!["preparation_time"],
          directions: recipe.data()!["directions"],
          ingredients: recipe.data()!["ingredients"],
          photo: recipe.data()!["photo"],
          notes: recipe.data()!["notes"]));
    }
    return recipes;
  }
}
