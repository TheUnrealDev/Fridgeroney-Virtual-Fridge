import 'package:firebase_database/firebase_database.dart';

class ItemCategory {
  final String typeName;
  final String? categoryId;

  ItemCategory({required this.typeName, this.categoryId});

  factory ItemCategory.fromDataSnapShot(DataSnapshot data) {
    Map<dynamic, dynamic> mapData = {
      for (DataSnapshot element in data.children)
        element.key ?? '': element.value ?? ''
    };

    return ItemCategory(
      categoryId: data.key,
      typeName: mapData['name'] ?? '',
    );
  }
}
