import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/shopping_list_item.dart';

import '../blocs/shopping_list/shopping_list_bloc.dart';

class AddShoppingListPage extends StatefulWidget {
  const AddShoppingListPage({Key? key}) : super(key: key);

  @override
  State<AddShoppingListPage> createState() => _AddShoppingListPageState();
}

class _AddShoppingListPageState extends State<AddShoppingListPage> {
  final TextEditingController _title = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final shoppingListBloc = BlocProvider.of<ShoppingListBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Alışveriş listesine ekle"),
            IconButton(
                onPressed: () {
                  shoppingListBloc.add(AddShoppingListEvent(
                      item: ShoppingListItem(text: _title.text)));

                  Navigator.pop(context);
                },
                icon: const Icon(Icons.save))
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                top: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05),
            child: TextField(
              controller: _title,
              decoration: InputDecoration(
                  labelText: "Başlık",
                  errorText: _title.text.isEmpty ? "gerekli" : null),
            ),
          )
        ],
      ),
    );
  }
}
