import 'dart:async';

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
  RecipeBloc() : super(RecipeInitial()) {
    on<RecipeAddEvent>(_recipeAddEvent);
  }

  FutureOr<void> _recipeAddEvent(RecipeAddEvent event, Emitter<RecipeState> emit) async{
       await _service.addRecipe(event.recipe);
  }
}
