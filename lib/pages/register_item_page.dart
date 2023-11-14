import 'package:flutter/material.dart';
import 'package:fridgeroney/data_classes/ingredient.dart';
import 'package:fridgeroney/models/ingredient_model.dart';
import 'package:fridgeroney/widgets/ingredient_form.dart';
import 'package:provider/provider.dart';

class RegisterItemPage extends StatefulWidget {
  final Ingredient newItem;
  const RegisterItemPage({super.key, required this.newItem});

  @override
  State<RegisterItemPage> createState() => _RegisterItemPageState();
}

class _RegisterItemPageState extends State<RegisterItemPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _itemNameController = TextEditingController();

  late IngredientModel ingredientModel;

  void submitForm() {
    bool isValidForm = _formKey.currentState?.validate() ?? false;
    if (!isValidForm) {
      return;
    }

    widget.newItem.name = _itemNameController.text;
    ingredientModel.addNewIngredient(widget.newItem);
    Navigator.popUntil(context, (route) => route.isFirst);
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
              IngredientInfoForm(
                formKey: _formKey,
                newItem: widget.newItem,
                itemNameController: _itemNameController,
              ),
              const SizedBox(
                height: 30,
              ),
              FilledButton(
                onPressed: submitForm,
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45, vertical: 18),
                  child: Text(
                    "Add Item",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
