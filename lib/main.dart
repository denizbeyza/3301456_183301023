import 'package:flutter/material.dart';
import 'package:recipe_keep/pages/bottom/home_page.dart';
import 'package:recipe_keep/pages/bottom/shopping_list_page.dart';
import 'package:recipe_keep/widgets/appbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index = 0;
  final pages = const [
    HomePage(),
    ShoppingListPage(),
    SizedBox(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: Scaffold(
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                tabItem(idx: 0, icon: const Icon(Icons.home_outlined)),
                tabItem(
                    idx: 1,
                    icon: const Icon(Icons.format_list_bulleted_rounded)),
                tabItem(idx: 2, icon: const Icon(Icons.settings)),
              ],
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                const CustomAppbar(),
                const SizedBox(height: 15),
                pages[index]
              ],
            ),
          ),
        ));
  }

  Widget tabItem({required int idx, required Icon icon}) {
    final isSelected = idx == index;
    return IconTheme(
        data: IconThemeData(color: isSelected ? Colors.orange : Colors.black),
        child: IconButton(
            onPressed: () {
              onChangedTab(idx);
            },
            icon: icon));
  }

  onChangedTab(int index) {
    setState(() => {this.index = index});
  }
}
