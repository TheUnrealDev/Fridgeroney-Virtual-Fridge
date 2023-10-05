import 'package:flutter/material.dart';
import 'package:fridgeroney/models/ingredient_model.dart';
import 'package:fridgeroney/models/scanned_ingredient_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../data_classes/ingredient.dart';

class OpenScanButton extends StatelessWidget {
  const OpenScanButton({super.key});

  void onBarCodeScanned(barCode, IngredientModel ingredientModel,
      ScannedIngredientModel scannedIngredientModel) {
    Ingredient? scannedIngredient =
        ingredientModel.getScannedIngredientFromBarCode(barCode);

    bool isNewItem = scannedIngredient == null;

    if (isNewItem) {
      scannedIngredient = Ingredient(barCode: barCode);
    }

    scannedIngredientModel.changeScannedIngredient(
      scannedIngredient,
      isNewItem,
    );

    if (!isNewItem) {
      debugPrint("Already scanned! Barcode: $barCode");
    } else {
      debugPrint(barCode);
    }
  }

  void scanBarCode(BuildContext context, IngredientModel ingredientModel,
      ScannedIngredientModel scannedIngredientModel) async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", false, ScanMode.BARCODE);
    if (barcodeScanRes == '-1') {
      debugPrint("No barcode found");
    } else {
      onBarCodeScanned(barcodeScanRes, ingredientModel, scannedIngredientModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    IngredientModel ingredientModel =
        Provider.of<IngredientModel>(context, listen: false);
    ScannedIngredientModel scannedIngredientModel =
        Provider.of<ScannedIngredientModel>(context, listen: false);

    return ElevatedButton(
      onPressed: () {
        scanBarCode(context, ingredientModel, scannedIngredientModel);
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: const SizedBox(
        height: 120,
        width: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.scanner,
              size: 50,
            ),
            Text(
              'Scan Item',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
