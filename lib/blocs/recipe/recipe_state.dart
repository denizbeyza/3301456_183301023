part of 'recipe_bloc.dart';

abstract class RecipeState {
  const RecipeState();


}

class RecipeInitial extends RecipeState {}

class LoadingRecipesState extends RecipeState {}

class LoadedRecipesState extends RecipeState {
  final List<Recipe> recipes;
  const LoadedRecipesState({required this.recipes});


}

class ErrorRecipesState extends RecipeState {}

