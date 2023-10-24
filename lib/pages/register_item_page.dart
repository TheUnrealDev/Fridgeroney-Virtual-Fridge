import 'package:flutter/material.dart';
import 'package:fridgeroney/data_classes/ingredient.dart';
import 'package:fridgeroney/models/ingredient_model.dart';
import 'package:provider/provider.dart';

class RegisterItemPage extends StatefulWidget {
  final Ingredient newItem;
  const RegisterItemPage({super.key, required this.newItem});

  @override
  State<RegisterItemPage> createState() => _RegisterItemPageState();
}

class _RegisterItemPageState extends State<RegisterItemPage> {
  final _formKey = GlobalKey<FormState>();
  final _itemNameController = TextEditingController(text: "Unknown");
  final _itemTypeController = TextEditingController();
  final _itemAmountController = TextEditingController(text: "1");
  late IngredientModel ingredientModel;

  void updateNewItem() {
    widget.newItem.name = _itemNameController.text;
    widget.newItem.ingredientType = _itemTypeController.text;
    widget.newItem.amount = int.tryParse(_itemAmountController.text) ?? 1;
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

  @override
  Widget build(BuildContext context) {
    ingredientModel = Provider.of<IngredientModel>(context);
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
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _itemTypeController,
                      validator: validateTextField,
                      decoration: const InputDecoration(
                        label: Text(
                          "Item Type",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: TextFormField(
                        controller: _itemAmountController,
                        validator: (value) {
                          if (value == null || int.tryParse(value) == null) {
                            return "Please input a whole number!";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text(
                            "Amount",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        onPressed: submitForm, child: const Text("Add Item")),
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
