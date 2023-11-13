import 'package:flutter/material.dart';

import '../pages/edit_item_page.dart';
import '../data_classes/ingredient.dart';

class FridgeItem extends StatefulWidget {
  final Ingredient ingredient;
  const FridgeItem({super.key, required this.ingredient});

  @override
  State<FridgeItem> createState() => _FridgeItemState();
}

class _FridgeItemState extends State<FridgeItem> {
  void onIngredientUpdated() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Theme.of(context).primaryColorLight,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.ingredient.ingredientType,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                widget.ingredient.name,
              ),
              Text(
                widget.ingredient.amount.toString(),
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                    minimumSize: Size.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditItemPage(
                        ingredient: widget.ingredient,
                        onUpdate: onIngredientUpdated,
                      ),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: Text("Edit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
