import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/shopping_list_item.dart';

class ShoppingListService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> addShoppingListItem(ShoppingListItem item) async {
    try {
      _firestore
          .collection("shopping_lists")
          .add(item.toJson())
          .then((value) async {
        var user = await _firestore
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .get();
        var userData = user.data();
        List<dynamic> shoppingLists = userData!["shopping_lists"];
        shoppingLists.add(value.id);
        _firestore
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .update({"shopping_lists": shoppingLists});
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  _getUserShoppingListsId() async {
    try {
      var doc = await _firestore
          .collection("users")
          .where("id", isEqualTo: _auth.currentUser!.uid)
          .get();
      var data = doc.docs[0].data();
      List<String> shoppingListId = [];
      for (var i in data["shopping_lists"]) {
        shoppingListId.add(i);
      }
      return shoppingListId;
    } catch (e) {
      print("==================$e");
    }
  }

  Future<List<ShoppingListItem>> getShoppinglists() async {
    List<ShoppingListItem> shoppingLists = [];

    try {
      List<String> shoppingListsId = await _getUserShoppingListsId();
      for (var i in shoppingListsId) {
        var shoppingList = await _firestore.doc("shopping_lists/$i").get();
        shoppingLists.add(ShoppingListItem(
            text: shoppingList.data()!["text"],
            checked: shoppingList.data()!["checked"]));
      }
      return shoppingLists;
    } catch (_) {
      return shoppingLists;
    }
  }
}
