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
    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SearchWidget(textController: c1, hintText: "Search Recipe"),
        )
      ],
    );
  }
}
