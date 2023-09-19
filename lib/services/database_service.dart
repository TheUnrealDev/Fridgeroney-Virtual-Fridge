import 'package:firebase_database/firebase_database.dart';
import 'package:fridgeroney/data_classes/ingredient.dart';

class DatabaseService {
  final String userId;

  late DatabaseReference recipesReference;
  late DatabaseReference ingredientsReference;

  DatabaseService({required this.userId}) {
    recipesReference = FirebaseDatabase.instance.ref('recipes/$userId');
    ingredientsReference =
        FirebaseDatabase.instance.ref('ingredients/'); //$userId
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

  Future<bool> getCommonRecipes() {
    return Future.delayed(const Duration(seconds: 2), () {
      return true;
    });
  }
}
