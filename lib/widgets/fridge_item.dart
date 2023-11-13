import 'package:flutter/material.dart';

import '../data_classes/ingredient.dart';

class FridgeItem extends StatefulWidget {
  final Ingredient ingredient;
  const FridgeItem({super.key, required this.ingredient});

  @override
  State<FridgeItem> createState() => _FridgeItemState();
}

class _FridgeItemState extends State<FridgeItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(widget.ingredient.ingredientType),
        ],
      ),
    );
  }
}
