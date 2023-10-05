import 'package:flutter/material.dart';
import 'package:fridgeroney/data_classes/ingredient.dart';
import 'package:fridgeroney/models/scanned_ingredient_model.dart';
import 'package:fridgeroney/widgets/scanned_item_dialog/known_item_scan_dialog.dart';
import 'package:fridgeroney/widgets/scanned_item_dialog/new_item_scan_dialog.dart';

class ItemScanDialog extends StatelessWidget {
  final ScannedIngredientModel scannedIngredientModel;

  const ItemScanDialog({super.key, required this.scannedIngredientModel});

  @override
  Widget build(BuildContext context) {
    Ingredient? scannedIngredient = scannedIngredientModel.scannedIngredient;
    if (scannedIngredient == null) {
      return AlertDialog(
        title: const Text("Error loading information about your scanned item!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Close"),
          ),
        ],
      );
    } else {
      if (scannedIngredientModel.isNewItem) {
        return NewItemScannedDialog(newItem: scannedIngredient);
      } else {
        return KnownItemScanDialog(newItem: scannedIngredient);
      }
    }
  }
}
