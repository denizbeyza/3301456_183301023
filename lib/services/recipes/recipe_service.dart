import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../models/recipe.dart';

class RecipesService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  addFavorite(Recipe recipe)async{
    try {
      _firestore.doc("recipes/${recipe.id}").update({
      "is_favorite": true,
    });

    } catch (_) {
      
    }
  }

  Future addRecipe(Recipe recipe, File? image) async {
    try {
      String photoName = DateTime.now().toString();
      if (image != null) {
        var reference =
            FirebaseStorage.instance.ref().child("images").child(photoName);
        await reference.putFile(image);
        String url = await reference.getDownloadURL();
        recipe.photo = url;
        recipe.photoName = photoName;
      }
      recipe.isFavorite = false;
      // recipe nesne colection klasör .then future dödürdüğü için bekliyosun value dönüypor
      _firestore.collection('recipes').add(recipe.toJson()).then((value) async {  // file private eğer alt tirey silseydik direkt ulaşılabilrdi
        var data = await value.get();

        var dataData = data.data();
        dataData!.addAll({"id": value.id}); // value.id dökümanın id si 
        value.set(dataData);
        var user = await _firestore
            .collection("users")
            .doc(_auth.currentUser!.uid) // login olmuş user i verir eğer varsa .uid yi firebase veriyor unic 
            .get(); // o dmkümanı çağırıyor beyza dökümanını örneğin
        var userData = user.data();
        List<dynamic> recipes = userData!["recipes"];
        recipes.add(value.id); // yemeğin id sini aktif olan user dökümanın içine vermiş
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
      return [];
    }
  }

  getRecipes() async {
    List<String> recipesId = await _getUserRecipesId();
    List<Recipe> recipes = [];
    for (var i in recipesId) {
      var recipe = await _firestore.doc("recipes/$i").get();
      recipes.add(Recipe(
          id: recipe.data()!["id"],
          title: recipe.data()!["title"],
          cookingTime: recipe.data()!["cooking_time"],
          preparationTime: recipe.data()!["preparation_time"],
          directions: recipe.data()!["directions"],
          ingredients: recipe.data()!["ingredients"],
          photo: recipe.data()!["photo"],
          isFavorite: recipe.data()!["is_favorite"],
          photoName: recipe.data()!["photoName"],
          notes: recipe.data()!["notes"]));
    }
    return recipes;
  }

  removeRecipe(Recipe recipe) async {  //tarif siliyor
    try {
      if (recipe.photo != null) {
        FirebaseStorage.instance
            .ref()
            .child("images")
            .child(recipe.photoName!)
            .delete();
      }

      _firestore.doc("recipes/${recipe.id}").delete();
      var userDoc = _firestore.doc("users/${_auth.currentUser!.uid}");
      var userData = await userDoc.get();

      List recipes = userData.data()!["recipes"];
      recipes.remove(recipe.id);
      userDoc.update({"recipes": recipes});
      return true;
    } catch (_) {
      return false;
    }
  }

  updateRecipe(Recipe recipe, cookingTime, directions, ingredients, notes, //firebase tarafındaki güncelleme işlemini yapıyor
      photo, preparationTime, title, isFavorite) async {
    String photoName = DateTime.now().toString();
    if (photo != null) {
      var reference =
          FirebaseStorage.instance.ref().child("images").child(photoName);
      await reference.putFile(photo);
      String url = await reference.getDownloadURL();
      recipe.photo = url;
      recipe.photoName = photoName;
    }
    _firestore.doc("recipes/${recipe.id}").update({
      "cooking_time": cookingTime,
      "directions": directions,
      "ingredients": ingredients,
      "notes": notes,
      "photo": recipe.photo,
      "photoName": recipe.photoName,
      "preparation_time": preparationTime,
      "is_favorite": isFavorite,
      "title": title
    });
  }

  removeImageFromRecipe(Recipe recipe) async {
    FirebaseStorage.instance
        .ref()
        .child("images")
        .child(recipe.photoName!)
        .delete();
    _firestore
        .doc("recipes/${recipe.id}")
        .update({"photo": null, "photoName": null});
  }

  getRecipesLength() async {
    List list = await getRecipes();
    return list.length;
  }
}
