import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../data_classes/item_category.dart';
import '../services/database_service.dart';

class CategoryModel extends ChangeNotifier {
  final DatabaseService databaseService =
      DatabaseService(userId: FirebaseAuth.instance.currentUser!.uid);

  List<ItemCategory> categories = [];

  CategoryModel() {
    databaseService.categoriesReference.onValue.listen(
      (event) {
        categories =
            databaseService.getCategoriesFromDataSnapshot(event.snapshot);
      },
    );
  }

  void addNewCategory(ItemCategory category) {
    databaseService.addNewCategory(category);
  }

  void removeCategory(ItemCategory category) {
    categories.removeWhere(
      (element) =>
          (category.categoryId != null) &&
          (category.categoryId == element.categoryId),
    );
    databaseService.removeCategory(category);
  }

  bool categoryExists(ItemCategory? category) {
    if (category == null) {
      return false;
    }
    for (ItemCategory existingCategory in categories) {
      if (existingCategory == category) {
        return true;
      }
    }
    return false;
  }
}
