import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fridgeroney/widgets/common_recipes_list.dart';
import 'package:fridgeroney/widgets/open_scan_page_button.dart';
import 'package:fridgeroney/widgets/page_select_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        toolbarHeight: 0,
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              PageSelectButton(
                buttonTitle: 'My Fridge',
                buttonIcon: Icons.kitchen,
              ),
              SizedBox(
                width: 2,
              ),
              PageSelectButton(
                buttonTitle: 'Recipes',
                buttonIcon: Icons.restaurant,
              ),
            ],
          ),
          OpenScanButton(),
          CommonRecipesList(),
        ],
      ),
    );
  }
}
