import 'package:flutter/material.dart';
import 'package:fridgeroney/data_classes/ingredient.dart';
import 'package:fridgeroney/widgets/ingredient_form.dart';
import 'package:provider/provider.dart';

import '../models/ingredient_model.dart';

class EditItemPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Ingredient ingredient;
  final Function onUpdate;

  EditItemPage({super.key, required this.ingredient, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    IngredientModel ingredientModel = Provider.of<IngredientModel>(context);
    final TextEditingController itemNameController =
        TextEditingController(text: ingredient.name);

    void updateItem() {
      ingredient.name = itemNameController.text;
      ingredientModel.addNewIngredient(ingredient);
      onUpdate();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Please update the information about your item!",
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IngredientInfoForm(
                formKey: _formKey,
                newItem: ingredient,
                itemNameController: itemNameController),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Cancel",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  FilledButton(
                    style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () {
                      updateItem();
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                      child: Text(
                        "Update Item",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
