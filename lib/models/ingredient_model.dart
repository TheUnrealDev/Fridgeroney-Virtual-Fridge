import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fridgeroney/data_classes/ingredient.dart';
import 'package:fridgeroney/services/database_service.dart';

class IngredientModel extends ChangeNotifier {
  final DatabaseService databaseService =
      DatabaseService(userId: FirebaseAuth.instance.currentUser!.uid);

  List<Ingredient> ingredients = [];

  IngredientModel() {
    databaseService.ingredientsReference.onValue.listen(
      (event) {
        ingredients =
            databaseService.getIngredientsFromDataSnapshot(event.snapshot);
      },
    );
  }

  Ingredient? getScannedIngredientFromBarCode(String barCode) {
    for (Ingredient ingredient in ingredients) {
      if (ingredient.barCode == barCode) {
        return ingredient;
      }
    }
    return null;
  }

  void addNewIngredient(Ingredient ingredient) {
    databaseService.addNewIngredient(ingredient);
  }
}
