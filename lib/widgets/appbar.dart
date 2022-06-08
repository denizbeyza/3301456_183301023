import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_keep/pages/add_recipe_page.dart';
import 'package:recipe_keep/pages/search_recipe.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            logo(context),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddRecipePage(),
                      ));
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.orange,
                )),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchRecipePage(),
                      ));
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.orange,
                ))
          ],
        ),
        Row(
          children: const [
            Expanded(
                child: Divider(
              thickness: 2.0,
            )),
          ],
        ),
      ],
    );
  }

  Padding logo(context) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.25),
      child: Row(
        children: [
          const Icon(
            Icons.dinner_dining_rounded,
            size: 25,
            color: Colors.orange,
          ),
          Text(
            "Recipe Keeper",
            style: GoogleFonts.oswald(color: Colors.orange, fontSize: 25),
          ),
        ],
      ),
    );
  }
}
