import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_keep/blocs/recipe/recipe_bloc.dart';
import 'package:recipe_keep/blocs/shopping_list/shopping_list_bloc.dart';
import 'package:recipe_keep/pages/add_recipe_page.dart';
import 'package:recipe_keep/pages/add_shopping_list_item.dart';
import 'package:recipe_keep/pages/bottom/home_page.dart';
import 'package:recipe_keep/pages/bottom/settings_page.dart';
import 'package:recipe_keep/pages/bottom/shopping_list_page.dart';
import 'package:recipe_keep/pages/auth/login_page.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => RecipeBloc(),
      ),
      BlocProvider(
        create: (context) => ShoppingListBloc(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool status;

  loginControl() {
    if (FirebaseAuth.instance.currentUser == null) {
      status = false;
    } else {
      status = true;
    }
  }

  @override
  void initState() {
    loginControl();
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      // statusBarBrightness: Brightness.dark,
      // statusBarIconBrightness: Brightness.dark,
      // statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: status ? const MainWidget() : const LoginPage());
  }
}

class MainWidget extends StatefulWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  int index = 0;
  final pages = const [
    HomePage(),
    ShoppingListPage(),
    SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.dinner_dining_rounded,
              size: 35,
              color: Theme.of(context).primaryColor,
            ),
            Text(
              "Recipe Keeper",
              style: GoogleFonts.oswald(
                  color: Theme.of(context).primaryColor, fontSize: 30),
            ),
          ],
        ),
      ),
      floatingActionButton: index == 0
          ? FloatingActionButton(
              child: const Icon(Icons.add, color: Colors.white),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddRecipePage(),
                    ));
              },
            )
          : index == 1
              ? FloatingActionButton(
                  child: const Icon(Icons.add, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddShoppingListPage(),
                        ));
                  },
                )
              : const SizedBox(),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            tabItem(idx: 0, icon: const Icon(Icons.home_outlined)),
            tabItem(
                idx: 1, icon: const Icon(Icons.format_list_bulleted_rounded)),
            tabItem(idx: 2, icon: const Icon(Icons.settings)),
          ],
        ),
      ),
      body: SafeArea(
        child: pages[index],
      ),
    );
  }

  Widget tabItem({required int idx, required Icon icon}) {
    final isSelected = idx == index;
    return IconTheme(
        data: IconThemeData(
            color: isSelected ? Theme.of(context).primaryColor : Colors.black),
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
