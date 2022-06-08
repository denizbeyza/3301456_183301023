import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_keep/widgets/shopping_list_item_widget.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({Key? key}) : super(key: key);

  @override
  State<ShoppingListPage> createState() => _ShoppingState();
}

class _ShoppingState extends State<ShoppingListPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shopping List',
                  style: GoogleFonts.lobster(fontSize: 25),
                ),
                IconButton(
                    iconSize: 25,
                    icon: const Icon(Icons.add),
                    onPressed: () {}),
              ],
            ),
            Row(
              children: const [
                Expanded(child: Divider()),
              ],
            ),
          ]),
        ),
        // ReorderableListView()
        const ShoppingListItem(
          title: "Tavuk",
        ),
        const ShoppingListItem(
          title: "Makarna",
        ),
        const ShoppingListItem(
          title: "Çorba",
        ),
        const ShoppingListItem(
          title: "Ispanak",
        ),
      ],
    );
  }
}
