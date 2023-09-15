import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CommonRecipeButton extends StatelessWidget {
  CommonRecipeButton({super.key});

  final DatabaseReference ref = FirebaseDatabase.instance.ref();
  void onPressed() async {
    debugPrint("done");
    await ref.update({"Hejsan/Time": 20});

    debugPrint("done 2");
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            children: [
              Icon(Icons.restaurant),
              SizedBox(
                width: 20,
              ),
              Text(
                'Recipe Name',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
