import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/shopping_list_item.dart';

class ShoppingListItemWidget extends StatefulWidget {
  final ShoppingListItem shoppingListItem;
  const ShoppingListItemWidget({
    Key? key,
    required this.shoppingListItem,
  }) : super(key: key);

  @override
  State<ShoppingListItemWidget> createState() => _ShoppingListItemWidgetState();
}

class _ShoppingListItemWidgetState extends State<ShoppingListItemWidget> {
  late bool _chechBoxValue;
  @override
  void initState() {
    super.initState();
    _chechBoxValue = widget.shoppingListItem.checked!;
  }

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
          widget.shoppingListItem.text!,
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
