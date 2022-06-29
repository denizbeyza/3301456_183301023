// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_keep/blocs/recipe/recipe_bloc.dart';

import '../models/recipe.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({Key? key}) : super(key: key);

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _preparationTime = TextEditingController();
  final TextEditingController _cookingTime = TextEditingController();
  final TextEditingController _ingredients = TextEditingController();
  final TextEditingController _directories = TextEditingController();
  final TextEditingController _notes = TextEditingController();
  File? image;

  @override
  Widget build(BuildContext context) {
    final recipeBloc = BlocProvider.of<RecipeBloc>(context);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: appBar(recipeBloc, context),
        body: tabBar(context),
      ),
    );
  }

  TabBarView tabBar(BuildContext context) {
    return TabBarView(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05),
            child: Column(
              children: [
                TextField(
                  controller: _title,
                  decoration: InputDecoration(
                      labelText: "Başlık",
                      errorText: _title.text.isEmpty ? "gerekli" : null),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                TextField(
                  controller: _preparationTime,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Hazırlama süresi"),
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                TextField(
                  controller: _cookingTime,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Pişirme süresi"),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _ingredients,
                      decoration: InputDecoration(
                        hintText: "Malzemeleri giriniz",
                      ),
                      scrollPadding: EdgeInsets.all(20.0),
                      keyboardType: TextInputType.multiline,
                      maxLines: 250,
                      autofocus: false,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _directories,
                      decoration: InputDecoration(
                        hintText: "Talimatları Giriniz",
                      ),
                      scrollPadding: EdgeInsets.all(20.0),
                      keyboardType: TextInputType.multiline,
                      maxLines: 250,
                      autofocus: false,
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _notes,
                      decoration: InputDecoration(
                        hintText: "Notlarınızı Giriniz",
                      ),
                      scrollPadding: EdgeInsets.all(20.0),
                      keyboardType: TextInputType.multiline,
                      maxLines: 250,
                      autofocus: false,
                    )
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              image != null
                  ? Image.file(
                      image!,
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.4,
                    )
                  : SizedBox(
                      height: 50,
                    ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                      onPressed: kameradanYukle,
                      icon: Icon(Icons.add_a_photo_outlined),
                      label: Text("Fotoğraf çek")),
                  ElevatedButton.icon(
                      onPressed: galeridenYukle,
                      icon: Icon(Icons.add_photo_alternate_outlined),
                      label: Text("Galeriden fotoğraf seç")),
                ],
              ),
            ],
          )
        ],
      );
  }

  AppBar appBar(RecipeBloc recipeBloc, BuildContext context) {
    return AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Yeni Tarif",
            ),
            IconButton( //kaydet butonu
                onPressed: () async {
                  if (_title.text.isNotEmpty) {
                    recipeBloc.add(
                      AddRecipeEvent(  // tetikle bloctaki o event çağırılıyor
                        image: image?.path ?? "",
                        recipe: Recipe(
                          title: _title.text,
                          cookingTime: _cookingTime.text,
                          directions: _directories.text,
                          ingredients: _ingredients.text,
                          notes: _notes.text,
                          preparationTime: _preparationTime.text,
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  } else {
                    // hata mesajı dönecek
                  }
                },
                icon: Icon(
                  Icons.save,
                ))
          ],
        ),
        bottom: TabBar(
          isScrollable: true,
          tabs: const [
            Tab(child: Text("GENEL")),
            Tab(child: Text("İÇİNDEKİLER")),
            Tab(child: Text("TALİMATLAR")),
            Tab(child: Text("NOTLAR")),
            Tab(child: Text("FOTOĞRAF")),
          ],
        ),
      );
  }

  kameradanYukle() async {
    var foto = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (foto != null) {
      setState(() {
        image = File(foto.path);
      });
    }
  }

  galeridenYukle() async {
    var foto = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (foto != null) {
      setState(() {
        image = File(foto.path);
      });
    }
  }
}
