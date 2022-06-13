part of 'shopping_list_bloc.dart';

abstract class ShoppingListEvent extends Equatable {
  const ShoppingListEvent();

  @override
  List<Object> get props => [];
}

class AddShoppingListEvent extends ShoppingListEvent {
  final ShoppingListItem item;
  const AddShoppingListEvent({required this.item});
}

class GetShoppingListsEvent extends ShoppingListEvent {}

class RefreshShoppingListsEvent extends ShoppingListEvent {}
