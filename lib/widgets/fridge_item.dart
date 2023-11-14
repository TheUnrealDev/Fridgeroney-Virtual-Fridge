import 'package:flutter/material.dart';
import 'package:fridgeroney/util/string_formatter.dart';

import '../pages/edit_item_page.dart';
import '../data_classes/ingredient.dart';

class FridgeItem extends StatefulWidget {
  final Ingredient ingredient;
  const FridgeItem({super.key, required this.ingredient});

  @override
  State<FridgeItem> createState() => _FridgeItemState();
}

class _FridgeItemState extends State<FridgeItem> {
  bool deleted = false;

  void onIngredientUpdated() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (deleted) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Theme.of(context).primaryColorLight,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      capitalizeString(widget.ingredient.ingredientType),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      capitalizeString(widget.ingredient.name),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: Expanded(
                  flex: 1,
                  child: Text(
                    widget.ingredient.amount.toString(),
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                    minimumSize: Size.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditItemPage(
                        ingredient: widget.ingredient,
                        onUpdate: onIngredientUpdated,
                      ),
                    ),
                  ).then(
                    (value) => {
                      if (value != null && value == "Deleted")
                        {
                          setState(
                            () {
                              deleted = true;
                            },
                          )
                        }
                    },
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
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
