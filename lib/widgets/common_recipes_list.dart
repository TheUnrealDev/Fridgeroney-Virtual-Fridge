import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fridgeroney/services/database_service.dart';

class CommonRecipesList extends StatefulWidget {
  const CommonRecipesList({super.key});

  @override
  State<CommonRecipesList> createState() => _CommonRecipesListState();
}

class _CommonRecipesListState extends State<CommonRecipesList> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    DatabaseService databaseService = DatabaseService(userId: user!.uid);

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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              child: FutureBuilder(
                  future: databaseService.getCommonRecipes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return const Text("hej");
                  }),
              /*child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CommonRecipeButton(),
                  CommonRecipeButton(),
                  CommonRecipeButton(),
                ],
              ),*/
            ),
          ),
        ],
      ),
    );
  }
}
