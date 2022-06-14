import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:recipe_keep/services/recipes/recipe_service.dart';
import 'package:recipe_keep/services/shopping_list/shopping_list_service.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({Key? key}) : super(key: key);

  @override
  State<GraphPage> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  final RecipesService _recipesService = RecipesService();
  final ShoppingListService _shoppingListService = ShoppingListService();
  int shoppingListLength = 0;
  int recipesLength = 0;

  @override
  void initState() {
    getData();
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Grafikler"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: DChartBar(
          data: [
            {
              'id': 'Bar',
              'data': [
                {'domain': 'Tarifler', 'measure': recipesLength},
                {'domain': 'Alışveriş Listesi', 'measure': shoppingListLength},
              ],
            },
          ],
          domainLabelPaddingToAxisLine: 18,
          axisLineTick: 2,
          axisLinePointTick: 2,
          axisLinePointWidth: 10,
          axisLineColor: Theme.of(context).primaryColor,
          measureLabelPaddingToAxisLine: 16,
          barColor: (barData, index, id) => Theme.of(context).primaryColor,
          showBarValue: true,
        ),
      ),
    );
  }

  void getData() async {
    int shoppingListLengthLocal =
        await _shoppingListService.getShoppinglistsLength();
    print(shoppingListLength);
    int recipesLengthLocal = await _recipesService.getRecipesLength();

    setState(() {
      recipesLength = recipesLengthLocal;
      shoppingListLength = shoppingListLengthLocal;
    });
  }
}
