import 'package:flutter/material.dart';
import 'package:fridgeroney/widgets/increment_field.dart';
import 'package:provider/provider.dart';

import '../../data_classes/ingredient.dart';
import '../../models/ingredient_model.dart';

class KnownItemScanDialog extends StatefulWidget {
  final Ingredient newItem;

  const KnownItemScanDialog({super.key, required this.newItem});

  @override
  State<KnownItemScanDialog> createState() => _KnownItemScanDialogState();
}

class _KnownItemScanDialogState extends State<KnownItemScanDialog> {
  void onAmountChanged(int newAmount) {
    widget.newItem.amount = newAmount;
  }

  void updateIngredient() {
    Provider.of<IngredientModel>(context, listen: false)
        .addNewIngredient(widget.newItem);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxHeight: 400),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "This looks like a known item!",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const Text(
                    "Scanned barcode:",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    widget.newItem.barCode,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Associated Item:",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    widget.newItem.name,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    widget.newItem.ingredientType,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              "Edit Item Count",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            IncrementField(
              onChangeFunction: onAmountChanged,
              initialValue: widget.newItem.amount,
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    child: TextButton(
                      onPressed: () {
                        updateIngredient();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Update Item",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 1,
                ),
                Expanded(
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
