import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:the_validator/the_validator.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late String _email;
  late String _password;
  late String _passwordConfirm;
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
                          "Register",
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
                                        _email = newValue!;
                                      });
                                    },
                                    autofocus: false,
                                    validator: (x) {
                                      if (x!.isEmpty) {
                                        return "Doldurulması Zorunludur!";
                                      } else {
                                        if (EmailValidator.validate(x) !=
                                            true) {
                                          return "Geçerli Bir Email Adresi Giriniz!";
                                        } else {
                                          return null;
                                        }
                                      }
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                        hintText: "Email",
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
                                    onSaved: (newValue) {
                                      setState(() {
                                        _password = newValue!;
                                      });
                                    },
                                    obscureText: true,
                                    validator: FieldValidator.password(
                                      minLength: 8,
                                      shouldContainNumber: true,
                                      errorMessage:
                                          "Minimum 8 Karakter uzunluğunda Olmalıdır!",
                                      onNumberNotPresent: () {
                                        return "Rakam İçermelidir!";
                                      },
                                    ),
                                    decoration: const InputDecoration(
                                        hintText: "Password",
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
                                    onSaved: (newValue) {
                                      setState(() {
                                        _passwordConfirm = newValue!;
                                      });
                                    },
                                    obscureText: true,
                                    validator: FieldValidator.password(
                                      minLength: 8,
                                      shouldContainNumber: true,
                                      errorMessage:
                                          "Minimum 8 Karakter uzunluğunda Olmalıdır!",
                                      onNumberNotPresent: () {
                                        return "Rakam İçermelidir!";
                                      },
                                    ),
                                    decoration: const InputDecoration(
                                        hintText: "Congirm password",
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
                          onTap: _register,
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: const Center(
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
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

  void _register() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (_password != _passwordConfirm) {
        _auth.signOut();
        Alert(
            type: AlertType.warning,
            context: context,
            title: "KAYIT EKLENEMEDİ",
            desc: "Şifreleriniz uyuşmuyor",
            buttons: [
              DialogButton(
                child: const Text(
                  "KAPAT",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ]).show();
      } else {
        try {
          var firebaseUser = await _auth
              .createUserWithEmailAndPassword(
                  email: _email, password: _password)
              .catchError((onError) {});
          // ignore: unnecessary_null_comparison
          if (firebaseUser != null) {
            _firestore.collection("users").doc(firebaseUser.user!.uid).set({
              "id": firebaseUser.user!.uid,
              "email": firebaseUser.user!.email,
              "shopping_lists":[],
              "recipes": []
            });
            _auth.signOut();
            Alert(
                type: AlertType.success,
                context: context,
                title: "KAYIT EKLENDİ!",
                desc: "Başarıyla kayıt oldunuz",
                buttons: [
                  DialogButton(
                    child: const Text(
                      "KAPAT",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    onPressed: () {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        Navigator.of(context, rootNavigator: true).pop();
                      });
                    },
                  )
                ]).show();
            formKey.currentState!.reset();

            _auth.signOut();
          } else {
            Alert(
                type: AlertType.warning,
                context: context,
                title: "KAYIT EKLENEMEDİ!",
                desc:
                    "Sisteme Kayıtlı Bir Email Adresi Girdiniz. \n Lütfen Farklı Bir Email Adresi Giriniz!",
                buttons: [
                  DialogButton(
                    child: const Text(
                      "KAPAT",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ]).show();
          }
        } on FirebaseAuthException {
          Alert(
              type: AlertType.warning,
              context: context,
              title: "KAYIT EKLENEMEDİ!",
              desc:
                  "Sisteme Kayıtlı Bir Email Adresi Girdiniz. \n Lütfen Farklı Bir Email Adresi Giriniz!",
              buttons: [
                DialogButton(
                  child: const Text(
                    "KAPAT",
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ]).show();
        }
      }
    }
  }
}
