import 'package:flutter/material.dart';
import 'package:fridgeroney/models/ingredient_model.dart';
import 'package:fridgeroney/widgets/fridge_item.dart';
import 'package:provider/provider.dart';

import '../data_classes/ingredient.dart';

class FridgePage extends StatefulWidget {
  const FridgePage({super.key});

  @override
  State<FridgePage> createState() => _FridgePageState();
}

class _FridgePageState extends State<FridgePage> {
  @override
  Widget build(BuildContext context) {
    IngredientModel ingredientModel = Provider.of<IngredientModel>(context);

    List<Ingredient> ingredients = ingredientModel.ingredients;
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
              Expanded(
                child: Scrollbar(
                  child: ListView.builder(
                    itemCount: ingredients.length,
                    itemBuilder: (context, int index) {
                      return FridgeItem(ingredient: ingredients[index]);
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
