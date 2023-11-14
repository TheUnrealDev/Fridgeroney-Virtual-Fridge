import 'package:flutter/material.dart';
import 'package:fridgeroney/data_classes/item_category.dart';
import 'package:fridgeroney/models/category_model.dart';
import 'package:fridgeroney/pages/create_category_page.dart';
import 'package:fridgeroney/util/string_formatter.dart';
import 'package:provider/provider.dart';

class SelectCategoryPage extends StatefulWidget {
  final bool allowCategoryCreation;
  const SelectCategoryPage({super.key, this.allowCategoryCreation = true});

  @override
  State<SelectCategoryPage> createState() => _SelectCategoryPageState();
}

class _SelectCategoryPageState extends State<SelectCategoryPage> {
  @override
  Widget build(BuildContext context) {
    CategoryModel categoryModel = Provider.of<CategoryModel>(context);
    List<ItemCategory> categories = categoryModel.categories;

    void createCategory() async {
      Future<ItemCategory?> newCategory = Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CreateCategoryPage(),
        ),
      );
      newCategory.then(
        (value) {
          debugPrint(value.toString());
          if (value != null) {
            Navigator.pop(context, newCategory);
          }
        },
      );
    }

    void deleteCategory(ItemCategory category) {
      setState(() {
        categoryModel.removeCategory(category);
      });
    }

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scrollbar(
          child: ListView.builder(
            itemCount: categories.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return !widget.allowCategoryCreation
                    ? Container()
                    : SizedBox(
                        height: 60,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          onPressed: createCategory,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Create New Category"),
                            ],
                          ),
                        ),
                      );
              }
              ItemCategory category = categories[index - 1];
              return Container(
                height: 60,
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context, category);
                        },
                        child: Text(capitalizeString(category.typeName)),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          deleteCategory(category);
                        },
                        icon: const Icon(Icons.delete))
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
