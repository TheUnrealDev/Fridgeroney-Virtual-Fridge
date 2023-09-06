import 'package:flutter/material.dart';
import 'package:fridgeroney/widgets/common_recipe_button.dart';

class CommonRecipesList extends StatefulWidget {
  const CommonRecipesList({super.key});

  @override
  State<CommonRecipesList> createState() => _CommonRecipesListState();
}

class _CommonRecipesListState extends State<CommonRecipesList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColorLight,
      height: 250,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Your Most Viewed Recipes',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CommonRecipeButton(),
                  CommonRecipeButton(),
                  CommonRecipeButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
