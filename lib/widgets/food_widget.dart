import 'package:flutter/material.dart';

class FoodWidget extends StatelessWidget {
  final String text;
  final String text2;
  final String url;
  final Function? onTap;
  const FoodWidget(
      {Key? key,
      required this.text,
      required this.url,
      required this.text2,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap == null) {
        } else {
          onTap!();
        }
      },
      child: Container(
        color: Colors.orange,
        height: 100,
        width: 100,
        child: Column(
          children: [
            Expanded(
                flex: 10,
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                )),
            Expanded(
                flex: 3,
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: Text(
                        text,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Text(
                      text2,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ))),
          ],
        ),
      ),
    );
  }
}
