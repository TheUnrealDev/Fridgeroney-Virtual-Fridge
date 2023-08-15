import 'package:flutter/material.dart';
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
        title: const Text(
          "Fridgeroney",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const Column(children: [
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
        )
      ]),
    );
  }
}
