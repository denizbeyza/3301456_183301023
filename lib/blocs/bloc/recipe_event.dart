part of 'recipe_bloc.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object> get props => [];
}

class AddRecipeEvent extends RecipeEvent {
  final String image;
  final Recipe recipe;
  const AddRecipeEvent( {required this.recipe,this.image = ""});

  @override
  List<Object> get props => [recipe,image];
}

class GetRecipesEvent extends RecipeEvent {}

class RefreshRecipeEvent extends RecipeEvent {}
