import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShoppingListItem extends StatefulWidget {
  final String title;
  const ShoppingListItem({Key? key, required this.title}) : super(key: key);

  @override
  State<ShoppingListItem> createState() => _ShoppingListItemState();
}

class _ShoppingListItemState extends State<ShoppingListItem> {
  bool _chechBoxValue = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: _chechBoxValue,
            onChanged: (bool? value) {
              setState(() {
                _chechBoxValue = value!;
              });
            }),
        Text(
          widget.title,
          style: GoogleFonts.jost(
              fontSize: 15,
              decoration: _chechBoxValue
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
        const Spacer(),
        const IconButton(onPressed: null, icon: Icon(Icons.edit))
      ],
    );
  }
}
