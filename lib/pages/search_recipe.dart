import 'package:flutter/material.dart';
import 'package:recipe_keep/widgets/search_widget.dart';

class SearchRecipePage extends StatefulWidget {
  const SearchRecipePage({Key? key}) : super(key: key);

  @override
  State<SearchRecipePage> createState() => _SearchRecipePageState();
}

class _SearchRecipePageState extends State<SearchRecipePage> {
  TextEditingController c1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: SearchInput(textController: c1, hintText: "Search Recipe"),
      ),
      body: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [const Text("data")],
      ),
    );
  }
}
