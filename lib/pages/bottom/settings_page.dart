import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_keep/blocs/recipe/recipe_bloc.dart';
import 'package:recipe_keep/blocs/theme/theme_bloc.dart';
import 'package:recipe_keep/pages/auth/login_page.dart';

import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? dropdownValue;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    List colors = [
      Colors.red,
      Colors.orange,
      Colors.blue,
      Colors.green,
      Colors.purple,
      Colors.pink,
      Colors.cyan,
      Colors.amber,
      Colors.lime,
      Colors.teal,
      Colors.brown,
      Colors.grey,
    ];
    final themeBloc = BlocProvider.of<ThemeBloc>(context);

    return SettingsList(
      sections: [
        SettingsSection(
          title: const Text('Language'),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: const Icon(Icons.language),
              title: const Text('Language'),
              value: const Text('English'),
              onPressed: (context) {},
            )
          ],
        ),
        SettingsSection(
          title: const Text('Theme'),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: const Icon(Icons.format_paint),
              title: const Text('Change Theme'),
              onPressed: (context) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Change Theme"),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        content: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.height * 0.3,
                          child: GridView.count(
                              crossAxisCount: 4,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              children: [
                                for (var item in colors)
                                  InkWell(
                                    onTap: () {
                                      themeBloc
                                          .add(ChangeThemeEvent(color: item));
                                    },
                                    child: Container(
                                      color: item,
                                      child: const SizedBox(),
                                    ),
                                  )
                              ]),
                        ),
                        actions: [
                          TextButton(
                            child: const Text("EVET"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    });
              },
            )
          ],
        ),
        SettingsSection(
          title: const Text('Auth'),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: const Icon(Icons.logout),
              title: const Text('Log out'),
              onPressed: (context) {
                _auth.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                    (route) => false);
              },
            )
          ],
        ),
      ],
    );
  }
}

// ElevatedButton(
//             onPressed: () async {
//               _auth.signOut();
//               Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const LoginPage(),
//                   ),
//                   (route) => false);
//             },
//             child: const Text("Çıkış Yap")),
