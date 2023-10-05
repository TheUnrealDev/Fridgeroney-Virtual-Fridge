import 'package:flutter/material.dart';

import '../../data_classes/ingredient.dart';

class NewItemScannedDialog extends StatefulWidget {
  final Ingredient newItem;

  const NewItemScannedDialog({super.key, required this.newItem});

  @override
  State<NewItemScannedDialog> createState() => _NewItemScannedDialogState();
}

class _NewItemScannedDialogState extends State<NewItemScannedDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxHeight: 400),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "This looks like a new item!",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    const Text(
                      "Scanned barcode:",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      widget.newItem.barCode,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Text(
                "Would you like to add it to your fridge?",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 1,
                ),
                Expanded(
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
