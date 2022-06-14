import 'dart:async';
import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';

import '../../models/recipe.dart';
import '../../services/recipes/recipe_service.dart';

part 'recipe_event.dart';
part 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final RecipesService _service = RecipesService();
  RecipeBloc() : super(RecipeInitial()) {
    on<AddRecipeEvent>(_recipeAddEvent);
    on<GetRecipesEvent>(_getRecipesEvent);
    on<RefreshRecipesEvent>(_refreshRecipeEvent);
    on<RemoveRecipeEvent>(_removeRecipeEvent);
    on<UpdateRecipeEvent>(_updateRecipeEvent);
    on<RemoveImageFromRecipeEvent>(_removeImageFromRecipeEvent);
  }

  Future<FutureOr<void>> _recipeAddEvent(AddRecipeEvent event, Emitter<RecipeState> emit) async {
    try {
      await _service.addRecipe(
          event.recipe, event.image.isEmpty ? null : File(event.image));
      
      emit(LoadedRecipesState(recipes: await _service.getRecipes()));
    } catch (_) {
      emit(ErrorRecipesState());
    }
  }

  Future<FutureOr<void>> _getRecipesEvent(GetRecipesEvent event, Emitter<RecipeState> emit) async {
    emit(LoadingRecipesState());
    try {
      emit(LoadedRecipesState(recipes: await _service.getRecipes()));
    } catch (_) {
      emit(ErrorRecipesState());
    }
  }

  Future<FutureOr<void>> _refreshRecipeEvent(RefreshRecipesEvent event, Emitter<RecipeState> emit) async {
    try {
      emit(LoadedRecipesState(recipes: await _service.getRecipes()));
    } catch (_) {
      emit(ErrorRecipesState());
    }
  }

  Future<FutureOr<void>> _removeRecipeEvent(RemoveRecipeEvent event, Emitter<RecipeState> emit) async {
    try {
      await _service.removeRecipe(event.recipe);
      emit(LoadedRecipesState(recipes: await _service.getRecipes()));
    } catch (_) {
      emit(ErrorRecipesState());
    }
  }

  Future<FutureOr<void>> _updateRecipeEvent(UpdateRecipeEvent event, Emitter<RecipeState> emit) async {
    await _service.updateRecipe(
        event.recipe,
        event.cookingTime,
        event.directions,
        event.ingredients,
        event.notes,
        event.photo,
        event.preparationTime,
        event.title,
        event.isFavorite);

    try {
      emit(LoadedRecipesState(recipes: await _service.getRecipes()));
    } catch (_) {
      emit(ErrorRecipesState());
    }
  }

  Future<FutureOr<void>> _removeImageFromRecipeEvent(RemoveImageFromRecipeEvent event, Emitter<RecipeState> emit) async {
    try {
    _service.removeImageFromRecipe(event.recipe);
      emit(LoadedRecipesState(recipes: await _service.getRecipes()));
    } catch (_) {
      emit(ErrorRecipesState());
    }
  }

  
}
