import 'package:flutter/material.dart';
import 'package:fridgeroney/models/ingredient_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class OpenScanButton extends StatelessWidget {
  const OpenScanButton({super.key});

  void scanBarCode(BuildContext context) async {
    IngredientModel ingredientModel =
        Provider.of<IngredientModel>(context, listen: false);
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", false, ScanMode.BARCODE);
    if (barcodeScanRes == '-1') {
      debugPrint("No barcode found");
    } else {
      if (ingredientModel.isInIngredientList(barcodeScanRes)) {
        debugPrint("Already scanned! Barcode: $barcodeScanRes");
      } else {
        debugPrint(barcodeScanRes);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        scanBarCode(context);
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
