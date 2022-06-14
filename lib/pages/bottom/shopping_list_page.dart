import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/shopping_list/shopping_list_bloc.dart';
import '../../widgets/shopping_list_item_widget.dart';

import '../../widgets/info_widget.dart';

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({Key? key}) : super(key: key);

  @override
  State<ShoppingListPage> createState() => _ShoppingState();
}

Completer<void> _refreshCompleter = Completer<void>();

class _ShoppingState extends State<ShoppingListPage> {
  @override
  Widget build(BuildContext context) {
    final shoppingListBloc = BlocProvider.of<ShoppingListBloc>(context);
    shoppingListBloc.add(GetShoppingListsEvent());
    return BlocBuilder<ShoppingListBloc, ShoppingListState>(
      bloc: shoppingListBloc,
      buildWhen: (previous, current) {
        return true;
      },
      builder: (context, state) {
        if (state is LoadedShoppingListState) {
          _refreshCompleter.complete();
          _refreshCompleter = Completer();
          if (state.shoppingLists.isEmpty) {
            return InkWell(
              onTap: () {
                shoppingListBloc.add(GetShoppingListsEvent());
              },
              child:
                  const InfoMessageWidget(message: "Henüz ürün eklememişsiniz"),
            );
          }
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
                padding: const EdgeInsets.all(5),
                child: RefreshIndicator(
                  onRefresh: () async {
                    shoppingListBloc.add(RefreshShoppingListsEvent());

                    return _refreshCompleter.future;
                  },
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.black,
                    ),
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state.shoppingLists.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        background: Container(color: Colors.red),
                        onDismissed: (direction) {
                          shoppingListBloc.add(RemoveShoppingListEvent(
                              item: state.shoppingLists[index]));

                          // setState(() {
                          //   state.shoppingLists.removeAt(index);
                          // });
                        },
                        key: Key(DateTime.now().toString()),
                        child: ShoppingListItemWidget(
                            shoppingListItem: state.shoppingLists[index]),
                      );
                    },
                  ),
                )),
          );
        }

        if (state is LoadingShoppingList) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ErrorShoppingListsState) {
          _refreshCompleter.complete();
          _refreshCompleter = Completer();
          return const Text("Error");
        }
        return const SizedBox();
      },
    );
  }
}
