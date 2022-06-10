import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_keep/models/recipe.dart';

class RecipesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> addRecipe(Recipe recipe) async {
    try {
      _firestore.collection('recipes').add(recipe.toJson());
      return true;
    } catch (_) {
      return false;
    }
  }
}
