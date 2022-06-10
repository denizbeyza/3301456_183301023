import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  Row logo(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.dinner_dining_rounded,
          size: 35,
          color: Colors.orange,
        ),
        Text(
          "Recipe Keeper",
          style: GoogleFonts.oswald(color: Colors.orange, fontSize: 30),
        ),
      ],
    );
  }
}
