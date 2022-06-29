import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:recipe_keep/services/shopping_list/shopping_list_service.dart';

import '../../models/shopping_list_item.dart';

part 'shopping_list_event.dart';
part 'shopping_list_state.dart';

class ShoppingListBloc extends Bloc<ShoppingListEvent, ShoppingListState> {
  final ShoppingListService _service = ShoppingListService();
  List<ShoppingListItem> lists = [];
  ShoppingListBloc() : super(ShoppingListInitial()) {
    on<AddShoppingListEvent>(_addShoppingListEvent);
    on<GetShoppingListsEvent>(_getShoppingListsEvent);
    on<RefreshShoppingListsEvent>(_refreshShoppingListsEvent);
    on<RemoveShoppingListEvent>(_removeShoppingListEvent);
  }

  FutureOr<void> _addShoppingListEvent(
      AddShoppingListEvent event, Emitter<ShoppingListState> emit) {
    try {
      _service.addShoppingListItem(event.item);
      lists.add(event.item);
      emit(LoadedShoppingListState(shoppingLists: lists));
    } catch (_) {
      emit(ErrorShoppingListsState());
    }
  }

  Future<FutureOr<void>> _getShoppingListsEvent(
      GetShoppingListsEvent event, Emitter<ShoppingListState> emit) async {
    emit(LoadingShoppingList());
    try {
      lists = await _service.getShoppinglists();
      emit(LoadedShoppingListState(shoppingLists: lists));
    } catch (_) {
      emit(ErrorShoppingListsState());
    }
  }

  Future<FutureOr<void>> _refreshShoppingListsEvent(
      RefreshShoppingListsEvent event, Emitter<ShoppingListState> emit) async {
    try {
      lists = await _service.getShoppinglists();

      emit(LoadedShoppingListState(shoppingLists: lists));
    } catch (_) {
      emit(ErrorShoppingListsState());
    }
  }

  Future<FutureOr<void>> _removeShoppingListEvent(
      RemoveShoppingListEvent event, Emitter<ShoppingListState> emit) async {
    try {
      await _service.removeShoppingListItem(event.item);
      lists.remove(event.item);
      emit(LoadedShoppingListState(shoppingLists: lists));
    } catch (_) {
      emit(ErrorShoppingListsState());
    }
  }
}
