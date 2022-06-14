import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_keep/blocs/recipe/recipe_bloc.dart';
import 'package:recipe_keep/blocs/theme/theme_bloc.dart';
import 'package:recipe_keep/pages/auth/login_page.dart';

import 'package:settings_ui/settings_ui.dart';

import '../../static/theme.dart';

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
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    List colors = Static.colors;
    return SettingsList(
      sections: [
        SettingsSection(
          title: const Text('Tema'),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: const Icon(Icons.format_paint),
              title: const Text('Tema Değiştir'),
              onPressed: (context) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Tema Değiştir"),
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
                            child: const Text("TAMAM"),
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
          title: const Text('Çıkış Yap'),
          tiles: <SettingsTile>[
            SettingsTile.navigation(
              leading: const Icon(Icons.logout),
              title: const Text('Çıkış Yap'),
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
