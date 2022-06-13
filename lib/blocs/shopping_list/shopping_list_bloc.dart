import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipe_keep/services/shopping_list/shopping_list_service.dart';

import '../../models/shopping_list_item.dart';

part 'shopping_list_event.dart';
part 'shopping_list_state.dart';

class ShoppingListBloc extends Bloc<ShoppingListEvent, ShoppingListState> {
  final ShoppingListService _service = ShoppingListService();
  ShoppingListBloc() : super(ShoppingListInitial()) {
    on<AddShoppingListEvent>(_addShoppingListEvent);
    on<GetShoppingListsEvent>(_getShoppingListsEvent);
    on<RefreshShoppingListsEvent>(_refreshShoppingListsEvent);
  }

  Future<FutureOr<void>> _addShoppingListEvent(
      AddShoppingListEvent event, Emitter<ShoppingListState> emit) async {
    _service.addShoppingListItem(event.item);
    emit(LoadingShoppingList());
    try {
      List<ShoppingListItem> list = await _service.getShoppinglists();

      emit(LoadedShoppingListState(shoppingLists: list));
    } catch (_) {
      emit(ErrorShoppingListsState());
    }
  }

  Future<FutureOr<void>> _getShoppingListsEvent(
      GetShoppingListsEvent event, Emitter<ShoppingListState> emit) async {
    emit(LoadingShoppingList());
    try {
      List<ShoppingListItem> list = await _service.getShoppinglists();
      emit(LoadedShoppingListState(shoppingLists: list));
    } catch (_) {
      emit(ErrorShoppingListsState());
    }
  }

  Future<FutureOr<void>> _refreshShoppingListsEvent(
      RefreshShoppingListsEvent event, Emitter<ShoppingListState> emit) async {
    try {
      List<ShoppingListItem> list = await _service.getShoppinglists();
      
      emit(LoadedShoppingListState(shoppingLists: list));
    } catch (_) {
      emit(ErrorShoppingListsState());
    }
  }
}
