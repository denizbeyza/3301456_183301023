part of 'recipe_bloc.dart';

abstract class RecipeState extends Equatable {
  const RecipeState();

  @override
  List<Object> get props => [];
}

class RecipeInitial extends RecipeState {}

class LoadingRecipesState extends RecipeState {}

class LoadedRecipesState extends RecipeState {
  final List<Recipe> recipes;
  const LoadedRecipesState({required this.recipes});

  @override
  List<Object> get props => [recipes];
}

class ErrorRecipesState extends RecipeState {}