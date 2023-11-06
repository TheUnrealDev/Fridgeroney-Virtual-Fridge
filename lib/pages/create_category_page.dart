import 'package:flutter/material.dart';
import 'package:fridgeroney/data_classes/item_category.dart';
import 'package:fridgeroney/models/category_model.dart';
import 'package:provider/provider.dart';

class CreateCategoryPage extends StatefulWidget {
  const CreateCategoryPage({super.key});

  @override
  State<CreateCategoryPage> createState() => _CreateCategoryPageState();
}

class _CreateCategoryPageState extends State<CreateCategoryPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController categoryNameController = TextEditingController();

  late CategoryModel categoryModel;

  void createCategory() {
    ItemCategory newCategory = ItemCategory(
        typeName: categoryNameController.text.trim().toLowerCase());
    categoryModel.addNewCategory(newCategory);

    Navigator.pop(context, newCategory);
  }

  void validateAndSubmit() {
    bool isValidForm = _formKey.currentState?.validate() ?? false;
    if (!isValidForm) {
      return;
    }
    createCategory();
  }

  @override
  Widget build(BuildContext context) {
    categoryModel = Provider.of<CategoryModel>(context);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Please fill out some information about your category!",
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "This field can not be empty!";
                  }
                  return null;
                },
                controller: categoryNameController,
                decoration: const InputDecoration(
                  label: Text(
                    "Category name:",
                    style: TextStyle(fontSize: 18),
                  ),
                  helperText: "Ex. Pasta, Ketchup",
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              FilledButton(
                onPressed: validateAndSubmit,
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Create Category"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
