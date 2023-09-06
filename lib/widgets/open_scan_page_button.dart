import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';


class OpenScanButton extends StatelessWidget {
  const OpenScanButton({super.key});

  void scanBarCode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666",
      "Cancel",
      false,
      ScanMode.BARCODE,
    );
    if (barcodeScanRes == '-1') {
      debugPrint("No barcode found");
    }
    debugPrint(barcodeScanRes);
    /*FlutterBarcodeScanner.getBarcodeStreamReceiver(
            "#ff6666", "Cancel", false, ScanMode.DEFAULT)
        ?.listen(
      (barcode) {
        debugPrint(barcode);
      },
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        scanBarCode();
        /*Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => ScanPage(camera: MyApp.mainCam)),
          ),
        );*/
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
