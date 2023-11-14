import 'package:firebase_database/firebase_database.dart';
import '../data_classes/item_category.dart';
import 'package:fridgeroney/data_classes/ingredient.dart';

class DatabaseService {
  final String userId;

  late DatabaseReference recipesReference;
  late DatabaseReference ingredientsReference;
  late DatabaseReference categoriesReference;

  DatabaseService({required this.userId}) {
    recipesReference = FirebaseDatabase.instance.ref('recipes/$userId');
    ingredientsReference = FirebaseDatabase.instance.ref('ingredients/$userId');
    categoriesReference =
        FirebaseDatabase.instance.ref('item_categories/$userId');
  }

  List<Ingredient> getIngredientsFromDataSnapshot(DataSnapshot data) {
    Iterable<DataSnapshot> ingredientList = data.children;
    List<Ingredient> ingredients = [];

    for (DataSnapshot ingredient in ingredientList) {
      Ingredient newIngredient = Ingredient.fromDataSnapShot(ingredient);
      ingredients.add(newIngredient);
    }
    return ingredients;
  }

  List<ItemCategory> getCategoriesFromDataSnapshot(DataSnapshot data) {
    Iterable<DataSnapshot> categoryList = data.children;
    List<ItemCategory> categories = [];

    for (DataSnapshot category in categoryList) {
      ItemCategory newCategory = ItemCategory.fromDataSnapShot(category);
      categories.add(newCategory);
    }
    return categories;
  }

  Future<bool> getCommonRecipes() {
    return Future.delayed(const Duration(seconds: 2), () {
      return true;
    });
  }

  void addNewIngredient(Ingredient ingredient) {
    ingredientsReference.update(
      {
        "${ingredient.barCode}/name": ingredient.name,
        "${ingredient.barCode}/type": ingredient.ingredientType,
        "${ingredient.barCode}/amount": ingredient.amount,
      },
    );
  }

  void deleteIngredient(Ingredient ingredient) {
    ingredientsReference.update(
      {
        ingredient.barCode: null,
      },
    );
  }

  void addNewCategory(ItemCategory category) {
    categoriesReference.push().set(
      {
        "name": category.typeName,
      },
    );
  }

  void removeCategory(ItemCategory category) {
    if (category.categoryId != null) {
      categoriesReference.update({category.categoryId!: null});
    }
  }
}
