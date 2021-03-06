import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../main.dart';
import 'resigters_page.dart';
import '../../widgets/google_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:the_validator/the_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var formKey = GlobalKey<FormState>();

  late String _email;
  late String _sifre;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage("assets/background.jpg"),
                fit: BoxFit.fitHeight),
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.1),
            ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            // #login, #welcome
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),

            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60)),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        const Text(
                          "Giri?? Yap",
                          style: TextStyle(color: Colors.black, fontSize: 40),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08,
                        ),
                        // #email, #password
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(171, 171, 171, .7),
                                  blurRadius: 20,
                                  offset: Offset(0, 10)),
                            ],
                          ),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200)),
                                  ),
                                  child: TextFormField(
                                    onSaved: (newValue) {
                                      setState(() {
                                        _email = newValue!.replaceAll(" ", "");
                                      });
                                    },
                                    autofocus: false,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Doldurulmas?? Zorunludur";
                                      } else {
                                        if (EmailValidator.validate(value.replaceAll(" ", "")) !=
                                            true) {
                                          return "Ge??erli Bir E-*posta giriniz";
                                        } else {
                                          return null;
                                        }
                                      }
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                        hintText: "E-posta",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200)),
                                  ),
                                  child: TextFormField(
                                    onSaved: (value) {
                                      _sifre = value!;
                                    },
                                    obscureText: true,
                                    validator: FieldValidator.password(
                                      minLength: 8,
                                      shouldContainNumber: true,
                                      errorMessage:
                                          "Minimum 8 Karakter uzunlu??unda Olmal??d??r!",
                                      onNumberNotPresent: () {
                                        return "Rakam ????ermelidir!";
                                      },
                                    ),
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "??ifre",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),

                        // #login
                        InkWell(
                          onTap: _login,
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: const Center(
                              child: Text(
                                "Giri?? Yap",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text('hen??z hesab??n??z yokmu?'),
                            TextButton(
                              child: const Text(
                                'Kay??t Olun!',
                                style:
                                    TextStyle(fontSize: 15, color: Colors.blue),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterPage(),
                                    ));
                              },
                            ),
                          ],
                        ),
                        GoogleButton(onPressed: loginWithGoogle)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        await _auth
            .signInWithEmailAndPassword(email: _email, password: _sifre)
            .then((user) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainWidget()),
              (r) => false);
          formKey.currentState!.reset();
        }).catchError((onError) {
          Alert(
              type: AlertType.warning,
              context: context,
              title: "Giri?? Yap??lamad??",
              desc: "E-postan??z veya ??ifreniz hatal??",
              buttons: [
                DialogButton(
                  child: const Text(
                    "Kapat",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                )
              ]).show();
        });
      } on FirebaseAuthException {
        Alert(
            type: AlertType.warning,
            context: context,
            title: "Giri?? Yap??lamad??",
            desc: "E-postan??z veya ??ifreniz hatal??",
            buttons: [
              DialogButton(
                child: const Text(
                  "Kapat",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                onPressed: () =>
                    Navigator.of(context, rootNavigator: true).pop(),
              )
            ]).show();
      }
    }
  }

  loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
      var user = _auth.currentUser!;
      var userDataSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();
      var userData = userDataSnapshot.data();
      if (userData!.isEmpty) {
        await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
          "id": user.uid,
          "email": user.email,
          "shopping_lists": [],
          "recipes": []
        });
      }

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainWidget()),
          (r) => false);
    } catch (_) {}
  }
}
