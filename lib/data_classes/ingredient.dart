import 'package:firebase_database/firebase_database.dart';

class Ingredient {
  final String barCode;
  String name;
  int amount;
  String ingredientType;

  Ingredient({
    required this.barCode,
    this.amount = 1,
    this.name = 'Default',
    this.ingredientType = '',
  });

  @override
  String toString() {
    return 'Barcode: $barCode, Name: $name, Amount: ${amount.toString()}';
  }

  factory Ingredient.fromDataSnapShot(DataSnapshot data) {
    Map<dynamic, dynamic> mapData = {
      for (DataSnapshot element in data.children)
        element.key ?? '': element.value ?? ''
    };

    if (mapData['amount'].runtimeType != int) {
      mapData['amount'] = 0;
    }

    return Ingredient(
      barCode: data.key ?? '',
      name: mapData['name'] ?? '',
      amount: mapData['amount'] ?? 0,
      ingredientType: mapData['type'] ?? '',
    );
  }
}
