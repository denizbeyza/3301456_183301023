import 'package:flutter/material.dart';
import 'package:recipe_keep/widgets/food_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _tabPages = [
    Padding(
      padding: const EdgeInsets.all(5),
      child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          children: const [
            FoodWidget(
                text: "mayonezli pilav",
                url:
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgv9xaDAT2JjUZmGe-Cl3lf58xJtqro5FoLw&usqp=CAU",
                text2: "4")
          ]),
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
    return DefaultTabController(
        length: _tabs.length, // length of tabs
        initialIndex: 0,
        child: Column(children: <Widget>[
          TabBar(
            labelColor: Colors.orange,
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
