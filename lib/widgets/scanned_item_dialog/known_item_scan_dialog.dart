import 'package:flutter/material.dart';

import '../../data_classes/ingredient.dart';

class KnownItemScanDialog extends StatefulWidget {
  final Ingredient newItem;

  const KnownItemScanDialog({super.key, required this.newItem});

  @override
  State<KnownItemScanDialog> createState() => _KnownItemScanDialogState();
}

class _KnownItemScanDialogState extends State<KnownItemScanDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("A known item has been scanned!"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}
