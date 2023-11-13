import 'package:flutter/material.dart';
import 'package:fridgeroney/models/ingredient_model.dart';
import 'package:fridgeroney/widgets/category_selector.dart';

import '../data_classes/ingredient.dart';
import '../data_classes/item_category.dart';
import 'increment_field.dart';

class IngredientInfoForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Ingredient newItem;
  final TextEditingController itemNameController;

  const IngredientInfoForm(
      {super.key,
      required this.formKey,
      required this.newItem,
      required this.itemNameController});

  @override
  State<IngredientInfoForm> createState() => _IngredientInfoFormState();
}

class _IngredientInfoFormState extends State<IngredientInfoForm> {
  int itemAmount = 1;
  ItemCategory? selectedCategory;
  late IngredientModel ingredientModel;

  String? validateTextField(String? text) {
    if (text == null || text.trim().isEmpty) {
      return "This field can not be empty!";
    }
    return null;
  }

  void onAmountChanged(newAmount) {
    widget.newItem.amount = newAmount;
    setState(() {
      itemAmount = newAmount;
    });
  }

  void onCategoryChanged(newCategory) {
    widget.newItem.ingredientType = newCategory?.typeName ?? 'Unknown';
    setState(() {
      selectedCategory = newCategory;
    });
  }

  @override
  Widget build(BuildContext context) {
    itemAmount = widget.newItem.amount;
    selectedCategory = ItemCategory(typeName: widget.newItem.ingredientType);

    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: widget.itemNameController,
            validator: validateTextField,
            decoration: const InputDecoration(
              label: Text(
                "Item Name",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          CategorySelectorField(
            onCategoryChanged: onCategoryChanged,
            intialCategory: widget.newItem.ingredientType == ''
                ? null
                : widget.newItem.ingredientType,
          ),
          const SizedBox(
            height: 30,
          ),
          FormField(
            builder: (field) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Item Amount:",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  IncrementField(
                    onChangeFunction: onAmountChanged,
                    initialValue: itemAmount,
                    minValue: 0,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
