import 'package:flutter/material.dart';
import 'package:fridgeroney/data_classes/ingredient.dart';
import 'package:fridgeroney/data_classes/item_category.dart';
import 'package:fridgeroney/models/category_model.dart';
import 'package:fridgeroney/models/ingredient_model.dart';
import 'package:fridgeroney/pages/select_category_page.dart';
import 'package:provider/provider.dart';

class RegisterItemPage extends StatefulWidget {
  final Ingredient newItem;
  const RegisterItemPage({super.key, required this.newItem});

  @override
  State<RegisterItemPage> createState() => _RegisterItemPageState();
}

class _RegisterItemPageState extends State<RegisterItemPage> {
  final _formKey = GlobalKey<FormState>();
  final _itemNameController = TextEditingController();

  int itemAmount = 1;

  String? itemTypeErrorMessage;

  ItemCategory? selectedCategory;
  late IngredientModel ingredientModel;
  late CategoryModel categoryModel;

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
          setState(
            () {
              selectedCategory = newCategory;
            },
          );
        }
      },
    );
  }

  void updateNewItem() {
    widget.newItem.name = _itemNameController.text;
    widget.newItem.ingredientType = selectedCategory!.typeName;
    widget.newItem.amount = itemAmount;
  }

  void submitForm() {
    bool isValidForm = _formKey.currentState?.validate() ?? false;
    if (!isValidForm) {
      return;
    }

    updateNewItem();
    ingredientModel.addNewIngredient(widget.newItem);
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  String? validateTextField(String? text) {
    if (text == null || text.trim().isEmpty) {
      return "This field can not be empty!";
    }
    return null;
  }

  void incrementItemAmount(int increment) {
    if (itemAmount + increment < 1) {
      // If the increment would cause itemAmount to become less than 1
      // Change the increment so that itemAmount becomes 1.
      increment = 1 - itemAmount;
    }
    setState(() {
      itemAmount += increment;
    });
  }

  @override
  Widget build(BuildContext context) {
    ingredientModel = Provider.of<IngredientModel>(context);
    categoryModel = Provider.of<CategoryModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Register new item!"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Please fill out some information about your item!",
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _itemNameController,
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
                    FormField(
                      validator: (value) {
                        String? errorMessage;
                        if (selectedCategory == null) {
                          errorMessage = "Please select an item type!";
                        }
                        setState(() {
                          itemTypeErrorMessage = errorMessage;
                        });
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30),
                                    child: Text(selectedCategory == null
                                        ? "Select"
                                        : selectedCategory!.capitalizeName()),
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
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    FormField(
                      builder: (field) {
                        return Column(
                          children: [
                            const Text(
                              "Item Amount:",
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    incrementItemAmount(-1);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                  ),
                                  child: const Text(
                                    "-",
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  itemAmount.toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    incrementItemAmount(1);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                  ),
                                  child: const Text(
                                    "+",
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    FilledButton(
                      onPressed: submitForm,
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 45, vertical: 18),
                        child: Text(
                          "Add Item",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
