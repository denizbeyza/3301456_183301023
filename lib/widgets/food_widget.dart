import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cacheing/image_cacheing.dart';
import '../pages/recipe_detail.dart';

import '../models/recipe.dart';

class FoodWidget extends StatelessWidget {
  final Recipe recipe;
  const FoodWidget({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailPage(recipe: recipe),
            ));
      },
      child: Container(
        color: Theme.of(context).primaryColor,
        height: 100,
        width: 100,
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: recipe.photo != null
                  ? ImageCacheing(
                      loadingWidget: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      height: 300,
                      width: 300,
                      fit: BoxFit.cover,
                      url: recipe.photo!,
                    )
                  : Image.asset(
                      "assets/food.png",
                      height: 300,
                      width: 300,
                      fit: BoxFit.cover,
                    ),
            ),
            Expanded(
                flex: 3,
                child: Center(
                    child: Text(recipe.title!,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.jost(
                            color: Colors.white, fontSize: 15)))),
          ],
        ),
      ),
    );
  }
}
