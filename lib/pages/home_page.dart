import 'package:flutter/material.dart';
import 'package:fridgeroney/data_classes/ingredient.dart';
import 'package:fridgeroney/models/scanned_ingredient_model.dart';
import 'package:fridgeroney/pages/fridge_page.dart';
import 'package:fridgeroney/pages/recipes_page.dart';
import 'package:fridgeroney/widgets/common_recipes_list.dart';
import 'package:fridgeroney/widgets/scanned_item_dialog/item_scan_dialog.dart';
import 'package:fridgeroney/widgets/open_scan_page_button.dart';
import 'package:fridgeroney/widgets/page_select_button.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isScanDialogVisible = false;

  void showScannedItemDialog(
      context, ScannedIngredientModel scannedIngredientModel) {
    isScanDialogVisible = true;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async => Future.value(false),
        child: ItemScanDialog(scannedIngredientModel: scannedIngredientModel),
      ),
    ).then(
      (value) => {
        isScanDialogVisible = false,
        scannedIngredientModel.scannedIngredient = null
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        toolbarHeight: 0,
      ),
      body: ChangeNotifierProvider<ScannedIngredientModel>(
        create: (context) => ScannedIngredientModel(),
        child: Consumer<ScannedIngredientModel>(
          builder: (context, scannedIngredientModel, child) {
            if (scannedIngredientModel.scannedIngredient != null &&
                !isScanDialogVisible) {
              Future.delayed(
                Duration.zero,
                () => showScannedItemDialog(context, scannedIngredientModel),
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    PageSelectButton(
                      targetPage: FridgePage(),
                      buttonTitle: 'My Fridge',
                      buttonIcon: Icons.kitchen,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    PageSelectButton(
                      targetPage: RecipesPage(),
                      buttonTitle: 'Recipes',
                      buttonIcon: Icons.restaurant,
                    ),
                  ],
                ),
                const OpenScanButton(),
                TextButton(
                  child: const Text("Scan New Item"),
                  onPressed: () {
                    Provider.of<ScannedIngredientModel>(context, listen: false)
                        .changeScannedIngredient(
                      Ingredient(barCode: "barcode0x2294"),
                      true,
                    );
                  },
                ),
                TextButton(
                  child: const Text("Scan Existing Item"),
                  onPressed: () {
                    Provider.of<ScannedIngredientModel>(context, listen: false)
                        .changeScannedIngredient(
                      Ingredient(barCode: "barcode0x2294"),
                      false,
                    );
                  },
                ),
                const CommonRecipesList(),
              ],
            );
          },
        ),
      ),
    );
  }
}
