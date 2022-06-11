// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_keep/blocs/bloc/recipe_bloc.dart';

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
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "New Repice",
              ),
              IconButton(
                  onPressed: () async {
                    if (_title.text.isNotEmpty) {
                      recipeBloc.add(
                        AddRecipeEvent(
                          image: image?.path ?? "",
                          recipe: Recipe(
                            title: _title.text,
                            cookingTime: _cookingTime.text.isEmpty
                                ? null
                                : int.parse(_cookingTime.text),
                            directions: _directories.text,
                            ingredients: _ingredients.text,
                            notes: _notes.text,
                            preparationTime: _preparationTime.text.isEmpty
                                ? null
                                : int.parse(_preparationTime.text),
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
              Tab(child: Text("OVERVIEW")),
              Tab(child: Text("INGREDIENTS")),
              Tab(child: Text("DIRECTIONS")),
              Tab(child: Text("NOTES")),
              Tab(child: Text("PHOTO")),
            ],
          ),
        ),
        body: TabBarView(
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
                        labelText: "Title",
                        errorText: _title.text.isEmpty ? "required" : null),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                  TextField(
                    controller: _preparationTime,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Preparation time"),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.06),
                  TextField(
                    controller: _cookingTime,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Cooking time"),
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
                          hintText: "Enter your ingredients",
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
                          hintText: "Enter your directions",
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
                          hintText: "Enter your notes",
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                    onPressed: kameradanYukle,
                    icon: Icon(Icons.add_a_photo_outlined),
                    label: Text("Take photo")),
                ElevatedButton.icon(
                    onPressed: galeridenYukle,
                    icon: Icon(Icons.add_photo_alternate_outlined),
                    label: Text("Choose photo from gallery")),
              ],
            )
          ],
        ),
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
