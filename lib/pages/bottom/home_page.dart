import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/food_widget.dart';
import '../../widgets/info_widget.dart';

import '../../blocs/recipe/recipe_bloc.dart';
import '../../widgets/error_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

Completer<void> _refreshCompleter = Completer<void>();

class _HomePageState extends State<HomePage> {
  final _tabPages = [
    BlocBuilder<RecipeBloc, RecipeState>(
      builder: (context, state) {
        final recipeBloc = BlocProvider.of<RecipeBloc>(context);

        if (state is LoadedRecipesState) {
          if (state.recipes.isEmpty) {
            return InkWell(
              onTap: () {
                recipeBloc.add(GetRecipesEvent());
              },
              child: const InfoMessageWidget(
                  message: "Henüz tarif eklememişsiniz"),
            );
          }

          _refreshCompleter.complete();
          _refreshCompleter = Completer();
          return Padding(
            padding: const EdgeInsets.all(5),
            child: RefreshIndicator(
              onRefresh: () {
                final recipeBloc = BlocProvider.of<RecipeBloc>(context);
                recipeBloc.add(RefreshRecipesEvent()); //yenilemek için
                return _refreshCompleter.future;
              },
              child: GridView.count( // kare kare tarifler listeleme işi 
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  children: [
                    for (var item in state.recipes)
                      FoodWidget(
                        recipe: item,
                      )
                  ]),
            ),
          );
        }
        if (state is LoadingRecipesState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ErrorRecipesState) {
          _refreshCompleter.complete();
          _refreshCompleter = Completer();
          return const ErrorMessageWidget(
            message: 'Hata Oluştu',
          );
        }
        return const SizedBox();
      },
    ),
    SizedBox(
      child: BlocBuilder<RecipeBloc, RecipeState>(
        builder: (context, state) {
          final recipeBloc = BlocProvider.of<RecipeBloc>(context);

          if (state is LoadedRecipesState) {
            if (state.recipes.isEmpty) {
              return InkWell(
                onTap: () {
                  recipeBloc.add(GetRecipesEvent());
                },
                child: const InfoMessageWidget(
                    message: "Henüz tarif eklememişsiniz"),
              );
            }

            _refreshCompleter.complete();
            _refreshCompleter = Completer();
            return Padding(
              padding: const EdgeInsets.all(5),
              child: RefreshIndicator(
                onRefresh: () {
                  final recipeBloc = BlocProvider.of<RecipeBloc>(context);
                  recipeBloc.add(RefreshRecipesEvent());
                  return _refreshCompleter.future;
                },
                child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    children: [
                      for (var item in state.recipes
                          .where((element) => element.isFavorite == true))
                        FoodWidget(recipe: item)
                    ]),
              ),
            );
          }
          if (state is LoadingRecipesState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ErrorRecipesState) {
            _refreshCompleter.complete();
            _refreshCompleter = Completer();
            return const ErrorMessageWidget(
              message: 'Hata Oluştu',
            );
          }
          return const SizedBox();
        },
      ),
    ),
  ];
  final _tabs = const [
    Tab(
      text: "Tariflerim",
    ),
    Tab(
      text: "Favorilerim",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final recipeBloc = BlocProvider.of<RecipeBloc>(context);
    recipeBloc.add(GetRecipesEvent());
    return DefaultTabController(
        length: _tabs.length, // length of tabs
        initialIndex: 0,
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            TabBar(
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.black,
              tabs: _tabs,
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: const BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.grey, width: 0.5))),
                child: TabBarView(children: _tabPages))
          ]),
        ));
  }
}
