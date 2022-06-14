import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../blocs/shopping_list/shopping_list_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          const Icon(
            Icons.circle,
            color: Colors.black,
            size: 10,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(widget.shoppingListItem.text!,
              style: GoogleFonts.jost(
                fontSize: 15,
              )),
        ],
      ),
    );
  }
}
