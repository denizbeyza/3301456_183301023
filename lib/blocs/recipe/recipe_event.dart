part of 'recipe_bloc.dart';

abstract class RecipeEvent{
  const RecipeEvent();

}

class AddRecipeEvent extends RecipeEvent {
  final String image;
  final Recipe recipe;
  const AddRecipeEvent({required this.recipe, this.image = ""});

}

class GetRecipesEvent extends RecipeEvent {}

class RefreshRecipesEvent extends RecipeEvent {}

class RemoveRecipeEvent extends RecipeEvent {
  final Recipe recipe;
  const RemoveRecipeEvent({required this.recipe});

}

class UpdateRecipeEvent extends RecipeEvent {
  final Recipe recipe;
  final String cookingTime;
  final String directions;
  final String ingredients;
  final String notes;
  final File? photo;
  final String preparationTime;
  final String title;
  final bool isFavorite;
  const UpdateRecipeEvent(this.cookingTime, this.directions, this.ingredients,
      this.notes, this.photo, this.preparationTime, this.title, this.isFavorite,
      {required this.recipe});


}

class RemoveImageFromRecipeEvent extends RecipeEvent {
    final Recipe recipe;
  const RemoveImageFromRecipeEvent(this.recipe);

}
