part of 'shopping_list_bloc.dart';

abstract class ShoppingListState extends Equatable {
  const ShoppingListState();

  @override
  List<Object> get props => [];
}

class ShoppingListInitial extends ShoppingListState {}
class LoadingShoppingList extends ShoppingListState {}

class LoadedShoppingListState extends ShoppingListState {
  final List<ShoppingListItem> shoppingLists;
  const LoadedShoppingListState({required this.shoppingLists});
  @override
  List<Object> get props => [shoppingLists];
}

class ErrorShoppingListsState extends ShoppingListState {}
