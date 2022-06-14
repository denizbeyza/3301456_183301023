part of 'shopping_list_bloc.dart';

abstract class ShoppingListEvent  {
  const ShoppingListEvent();


}

class AddShoppingListEvent extends ShoppingListEvent {
  final ShoppingListItem item;
  const AddShoppingListEvent({required this.item});


}

class GetShoppingListsEvent extends ShoppingListEvent {}

class RefreshShoppingListsEvent extends ShoppingListEvent {}

class RemoveShoppingListEvent extends ShoppingListEvent {
  final ShoppingListItem item;
  const RemoveShoppingListEvent({required this.item});

}

