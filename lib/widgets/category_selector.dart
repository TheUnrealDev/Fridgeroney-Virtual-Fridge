import 'package:flutter/material.dart';
import 'package:fridgeroney/util/string_formatter.dart';
import 'package:provider/provider.dart';

import '../data_classes/item_category.dart';
import '../models/category_model.dart';
import '../pages/select_category_page.dart';

class CategorySelectorField extends StatefulWidget {
  final Function onCategoryChanged;
  final String? intialCategory;
  const CategorySelectorField(
      {super.key, required this.onCategoryChanged, this.intialCategory});

  @override
  State<CategorySelectorField> createState() => _CategorySelectorFieldState();
}

class _CategorySelectorFieldState extends State<CategorySelectorField> {
  ItemCategory? selectedCategory;
  late CategoryModel categoryModel;

  String? itemTypeErrorMessage;

  void selectCategory() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => const SelectCategoryPage()),
      ),
    ).then(
      (value) {
        ItemCategory? newCategory = selectedCategory;
        if (value.runtimeType == ItemCategory) {
          newCategory = value;
        } else if (!categoryModel.categoryExists(selectedCategory)) {
          newCategory = null;
        }

        if (selectedCategory != newCategory) {
          widget.onCategoryChanged(newCategory);
          setState(
            () {
              selectedCategory = newCategory;
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    categoryModel = Provider.of<CategoryModel>(context);
    return FormField(
      validator: (value) {
        String? errorMessage;
        if (selectedCategory == null) {
          errorMessage = "Please select an item type!";
        }
        setState(() {
          itemTypeErrorMessage = errorMessage;
        });
        return;
      },
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                const Text(
                  "Item Type:",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  width: 15,
                ),
                FilledButton(
                  onPressed: selectCategory,
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      capitalizeString(selectedCategory == null
                          ? widget.intialCategory ?? "Select"
                          : selectedCategory!.typeName),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              itemTypeErrorMessage ?? '',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        );
      },
    );
  }
}
