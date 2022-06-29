import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cacheing/image_cacheing.dart';
import 'package:image_picker/image_picker.dart';

import '../blocs/recipe/recipe_bloc.dart';
import '../models/recipe.dart';

class RecipeDetailPage extends StatefulWidget {
  final Recipe recipe;
  const RecipeDetailPage({Key? key, required this.recipe}) : super(key: key);

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _preparationTime = TextEditingController();
  final TextEditingController _cookingTime = TextEditingController();
  final TextEditingController _ingredients = TextEditingController();
  final TextEditingController _directions = TextEditingController();
  final TextEditingController _notes = TextEditingController();
  late String? image;
  File? file;

  @override
  void initState() {
    _title.text = widget.recipe.title!;
    _preparationTime.text = widget.recipe.preparationTime.toString();
    _cookingTime.text = widget.recipe.cookingTime.toString();
    _ingredients.text = widget.recipe.ingredients ?? "";
    _directions.text = widget.recipe.directions ?? "";
    _notes.text = widget.recipe.notes ?? "";
    image = widget.recipe.photo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final recipeBloc = BlocProvider.of<RecipeBloc>(context);

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: appBar(context, recipeBloc),
        body: body(context, recipeBloc),
      ),
    );
  }

  TabBarView body(BuildContext context, RecipeBloc recipeBloc) {
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
                decoration:
                    const InputDecoration(labelText: "Hazırlama süresi"),
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.06),
              TextField(
                controller: _cookingTime,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Pişirme süresi"),
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
                    decoration: const InputDecoration(
                      hintText: "Malzemeleri giriniz",
                    ),
                    scrollPadding: const EdgeInsets.all(20.0),
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
                    controller: _directions,
                    decoration: const InputDecoration(
                      hintText: "Talimatları Giriniz",
                    ),
                    scrollPadding: const EdgeInsets.all(20.0),
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
                    decoration: const InputDecoration(
                      hintText: "Notlarınızı Giriniz",
                    ),
                    scrollPadding: const EdgeInsets.all(20.0),
                    keyboardType: TextInputType.multiline,
                    maxLines: 250,
                    autofocus: false,
                  )
                ],
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              image != null
                  ? Column(
                      children: [
                        Hero(
                          tag: image!.hashCode,
                          child: ImageCacheing(
                            url: image!,
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.height * 0.5,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ElevatedButton.icon(
                            onPressed: kameradanYukle,
                            icon: const Icon(Icons.add_a_photo_outlined),
                            label: const Text("Fotoğrafı değiştir")),
                        ElevatedButton.icon(
                            onPressed: galeridenYukle,
                            icon:
                                const Icon(Icons.add_photo_alternate_outlined),
                            label: const Text("Fotoğrafı galeriden değiştir")),
                        ElevatedButton.icon(
                            onPressed: () {
                              recipeBloc.add(
                                  RemoveImageFromRecipeEvent(widget.recipe));
                              setState(() {
                                // widget.recipe.photo = null;
                                // widget.recipe.photoName = null;
                                // file = null;
                                image = null;
                              });
                            },
                            icon: const Icon(Icons.add_a_photo_outlined),
                            label: const Text("Fotoğrafı sil")),
                      ],
                    )
                  : file != null
                      ? Image.file(file!)
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                            ),
                            ElevatedButton.icon(
                                onPressed: kameradanYukle,
                                icon: const Icon(Icons.add_a_photo_outlined),
                                label: const Text("Fotoğraf çek")),
                            ElevatedButton.icon(
                                onPressed: galeridenYukle,
                                icon: const Icon(
                                    Icons.add_photo_alternate_outlined),
                                label: const Text("Galeriden fotoğraf seç")),
                          ],
                        ),
            ],
          ),
        )
      ],
    );
  }

  AppBar appBar(BuildContext context, RecipeBloc recipeBloc) {
    return AppBar(
      // tarif detayları kodlamadaki yeri
      title: Row(
        children: [
          Expanded(
              child: Text(
            widget.recipe.title!,
            overflow: TextOverflow.ellipsis,
          )),
          IconButton(
              // favorilere ekle
              onPressed: () async {
                FirebaseFirestore.instance
                    .doc("recipes/${widget.recipe.id}")
                    .update({"is_favorite": !widget.recipe.isFavorite!});
                setState(() {
                  widget.recipe.isFavorite = !widget.recipe.isFavorite!;
                });
              },
              icon: Icon(
                  widget.recipe.isFavorite! ? Icons.star : Icons.star_border)),
          IconButton(
              // silmek için
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title:
                              const Text("Silmek istediğinize emin misiniz?"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () async {
                                recipeBloc.add(RemoveRecipeEvent(
                                    //event
                                    recipe: widget.recipe));
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text("EVET"),
                            ),
                          ],
                        ));
              },
              icon: const Icon(
                Icons.delete,
              )),
          IconButton(
              onPressed: () async {
                recipeBloc.add(UpdateRecipeEvent(
                    _cookingTime.text,
                    _directions.text,
                    _ingredients.text,
                    _notes.text,
                    // ignore: prefer_if_null_operators
                    file != null ? file : null,
                    _preparationTime.text,
                    _title.text,
                    widget.recipe.isFavorite!,
                    recipe: widget.recipe));
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.check,
              ))
        ],
      ),
      bottom: const TabBar(
        isScrollable: true,
        tabs: [
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
        widget.recipe.photo = null;
        image = null;
        file = File(foto.path);
      });
    }
  }

  galeridenYukle() async {
    var foto = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (foto != null) {
      setState(() {
        widget.recipe.photo = null;

        image = null;
        file = File(foto.path);
      });
    }
  }
}
