import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cacheing/image_cacheing.dart';
import '../animations/heart_animation.dart';

import '../blocs/recipe/recipe_bloc.dart';
import '../pages/recipe_detail.dart';

import '../models/recipe.dart';

class FoodWidget extends StatefulWidget {
  final Recipe recipe;
  const FoodWidget({Key? key, required this.recipe}) : super(key: key);

  @override
  State<FoodWidget> createState() => _FoodWidgetState();
}

class _FoodWidgetState extends State<FoodWidget> {
  late Offset _tapPosition;
  bool isHeartAnimation = false;
  void _storePosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  Widget build(BuildContext context) {
    final recipeBloc = context.read<RecipeBloc>();

    return GestureDetector(
      onTapDown: _storePosition,
      onDoubleTap: () {
        setState(() {
          isHeartAnimation = true;
          widget.recipe.isFavorite = true;
        });
        recipeBloc.add(AddFavoriteEvent(widget.recipe));
      },
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailPage(recipe: widget.recipe),
            ));
      },
      onLongPress: () {
        final RenderObject? overlay =
            Overlay.of(context)!.context.findRenderObject();
        showMenu(
            items: <PopupMenuEntry>[
              PopupMenuItem(
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          recipeBloc.add(RemoveRecipeEvent(
                              //event
                              recipe: widget.recipe));
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.delete)),
                    const Text("sil")
                  ],
                ),
              ),
            ],
            context: context,
            position: RelativeRect.fromRect(
                _tapPosition &
                    const Size(40, 40), // smaller rect, the touch area
                overlay!.semanticBounds // Bigger rect, the entire screen
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
                child: Stack(
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: Hero(
                          tag: widget.recipe.photo != null
                              ? widget.recipe.photo!.hashCode
                              : widget.recipe,
                          child: widget.recipe.photo != null
                              ? ImageCacheing(
                                  loadingWidget: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  height: 300,
                                  width: 300,
                                  fit: BoxFit.cover,
                                  url: widget.recipe.photo!,
                                )
                              : Image.asset(
                                  "assets/food.png",
                                  height: 300,
                                  width: 300,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Opacity(
                        opacity: isHeartAnimation ? 1 : 0,
                        child: HeartAnimationWidget(
                          onEnd: () {
                            setStateIfMounted(() {
                              isHeartAnimation = false;
                            });
                          },
                          isAnimating: isHeartAnimation,
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 80,
                          ),
                        ),
                      )
                    ])),
            Expanded(
                flex: 3,
                child: Center(
                    child: Text(widget.recipe.title!,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.jost(
                            color: Colors.white, fontSize: 15)))),
          ],
        ),
      ),
    );
  }
}
