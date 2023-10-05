import 'package:flutter/material.dart';

import '../data_classes/ingredient.dart';

class ScannedIngredientModel extends ChangeNotifier {
  Ingredient? scannedIngredient;
  bool isNewItem = false;

  ScannedIngredientModel();

  void changeScannedIngredient(Ingredient? newIngredient, bool isNewItem) {
    this.isNewItem = isNewItem;
    scannedIngredient = newIngredient;
    notifyListeners();
  }
}
