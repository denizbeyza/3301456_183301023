import 'dart:async';
import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../models/recipe.dart';
import '../../services/recipes/recipe_service.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final RecipesService _service = RecipesService();
  List<Recipe> recipes = [];
  RecipeBloc() : super(RecipeInitial()) {
    on<AddRecipeEvent>(_recipeAddEvent);
    on<GetRecipesEvent>(_getRecipesEvent);
    on<RefreshRecipeEvent>(_refreshRecipeEvent);
  }

  Future<FutureOr<void>> _recipeAddEvent(
      AddRecipeEvent event, Emitter<RecipeState> emit) async {
    _service.addRecipe(
        event.recipe, event.image.isEmpty ? null : File(event.image));
  }

  Future<FutureOr<void>> _getRecipesEvent(
      GetRecipesEvent event, Emitter<RecipeState> emit) async {
    emit(LoadingRecipesState());
    try {
      recipes = await _service.getRecipes();
      emit(LoadedRecipesState(recipes: recipes));
    } catch (_) {
      emit(ErrorRecipesState());
    }
  }

  Future<FutureOr<void>> _refreshRecipeEvent(RefreshRecipeEvent event, Emitter<RecipeState> emit) async {
    try {
      recipes = await _service.getRecipes();
      emit(LoadedRecipesState(recipes: recipes));
    } catch (_) {
      emit(ErrorRecipesState());
    }
  }
}
