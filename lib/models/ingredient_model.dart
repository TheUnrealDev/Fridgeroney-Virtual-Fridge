import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fridgeroney/data_classes/ingredient.dart';
import 'package:fridgeroney/services/database_service.dart';

class IngredientModel extends ChangeNotifier {
  final DatabaseService databaseService =
      DatabaseService(userId: FirebaseAuth.instance.currentUser!.uid);

  List<Ingredient> ingredients = [];

  IngredientModel() {
    debugPrint("ingredient model created");

    databaseService.ingredientsReference.onValue.listen(
      (event) {
        ingredients =
            databaseService.getIngredientsFromDataSnapshot(event.snapshot);
      },
    );
  }

  bool isInIngredientList(String barCode) {
    for (Ingredient ingredient in ingredients) {
      if (ingredient.barCode == barCode) {
        return true;
      }
    }
    return false;
  }
}
