part of 'shopping_list_bloc.dart';

abstract class ShoppingListState  {
  const ShoppingListState();


}

class ShoppingListInitial extends ShoppingListState {}
class LoadingShoppingList extends ShoppingListState {}

class LoadedShoppingListState extends ShoppingListState {
  final List<ShoppingListItem> shoppingLists;
  const LoadedShoppingListState({required this.shoppingLists});

}

class ErrorShoppingListsState extends ShoppingListState {}
