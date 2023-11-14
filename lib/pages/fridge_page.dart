import 'package:flutter/material.dart';
import 'package:fridgeroney/data_classes/item_category.dart';
import 'package:fridgeroney/models/category_model.dart';
import 'package:fridgeroney/models/ingredient_model.dart';
import 'package:fridgeroney/pages/select_category_page.dart';
import 'package:fridgeroney/util/string_formatter.dart';
import 'package:fridgeroney/widgets/category_selector.dart';
import 'package:fridgeroney/widgets/fridge_item.dart';
import 'package:provider/provider.dart';

import '../data_classes/ingredient.dart';

class FridgePage extends StatefulWidget {
  const FridgePage({super.key});

  @override
  State<FridgePage> createState() => _FridgePageState();
}

class _FridgePageState extends State<FridgePage> {
  bool showEmptyItems = false;
  ItemCategory? filteredCategory;

  List<Ingredient> filterIngredients(
      List<Ingredient> originalIngredients, ItemCategory filterCategory) {
    var filteredList = List<Ingredient>.from(originalIngredients);
    filteredList.removeWhere((Ingredient ingredient) =>
        ingredient.ingredientType != filterCategory.typeName);

    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<CategoryModel>(context);

    void filteredCategoryChanged(ItemCategory? newCategory) {
      setState(() {
        filteredCategory = newCategory;
      });
    }

    IngredientModel ingredientModel = Provider.of<IngredientModel>(context);

    List<Ingredient> ingredients = ingredientModel.ingredients;

    if (filteredCategory != null) {
      ingredients = filterIngredients(ingredients, filteredCategory!);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Your Fridge",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Filter By Category"),
                      Row(
                        children: [
                          FilledButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const SelectCategoryPage(
                                      allowCategoryCreation: false,
                                    );
                                  },
                                ),
                              ).then((newFilterCategory) {
                                filteredCategoryChanged(newFilterCategory);
                              });
                            },
                            style: FilledButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            child: Text(
                              filteredCategory != null
                                  ? capitalizeString(filteredCategory!.typeName)
                                  : "Select",
                            ),
                          ),
                          filteredCategory == null
                              ? Container()
                              : IconButton(
                                  onPressed: () {
                                    filteredCategoryChanged(null);
                                  },
                                  icon: const Icon(Icons.clear),
                                )
                        ],
                      ),
                    ],
                  ),
                  FilledButton(
                    onPressed: () {
                      setState(() {
                        showEmptyItems = !showEmptyItems;
                      });
                    },
                    child:
                        Text("${showEmptyItems ? "Hide" : "Show"} Empty Items"),
                  ),
                ],
              ),
              Expanded(
                child: Scrollbar(
                  interactive: true,
                  child: ListView.builder(
                    itemCount: ingredients.length,
                    itemBuilder: (context, int index) {
                      if (!showEmptyItems && ingredients[index].amount <= 0) {
                        return Container();
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: FridgeItem(ingredient: ingredients[index]),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
