part of 'recipe_bloc.dart';

abstract class RecipeEvent extends Equatable {
  const RecipeEvent();

  @override
  List<Object> get props => [];
}

class RecipeAddEvent extends RecipeEvent {
  final Recipe recipe;
  const RecipeAddEvent({required this.recipe});

  @override
  List<Object> get props => [recipe];
}
