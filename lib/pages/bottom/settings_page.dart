import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_keep/models/recipe.dart';
import 'package:recipe_keep/services/recipes/recipe_service.dart';

import '../auth/login_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  final RecipesService _service = RecipesService();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            onPressed: () async {
              for (var element in await _service.getRecipes()) {
                print(element.cookingTime);
              }
            },
            child: const Text("deeme")),
        ElevatedButton(
            onPressed: () async {
              _auth.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                  (route) => false);
            },
            child: const Text("Çıkış Yap")),
      ],
    );
  }
}
