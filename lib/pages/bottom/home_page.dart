import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_keep/widgets/food_widget.dart';

import '../../blocs/bloc/recipe_bloc.dart';

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
        if (state is LoadedRecipesState) {
          _refreshCompleter.complete();
          _refreshCompleter = Completer();
          return Padding(
            padding: const EdgeInsets.all(5),
            child: RefreshIndicator(
              onRefresh: () {
                final _recipeBloc = BlocProvider.of<RecipeBloc>(context);
                _recipeBloc.add(RefreshRecipeEvent());
                return _refreshCompleter.future;
              },
              child: GridView.count(
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
          return const Text("Error");
        }
        return const SizedBox();
      },
    ),
    const Text("3"),
  ];
  final _tabs = const [
    Tab(
      text: "Recipes",
    ),
    Tab(
      text: "Favorites",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final _recipeBloc = BlocProvider.of<RecipeBloc>(context);
    _recipeBloc.add(GetRecipesEvent());
    return DefaultTabController(
        length: _tabs.length, // length of tabs
        initialIndex: 0,
        child: Column(children: <Widget>[
          TabBar(
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.black,
            tabs: _tabs,
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.grey, width: 0.5))),
              child: TabBarView(children: _tabPages))
        ]));
  }
}
