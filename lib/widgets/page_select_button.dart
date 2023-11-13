import 'package:flutter/material.dart';

class PageSelectButton extends StatelessWidget {
  final String buttonTitle;
  final IconData buttonIcon;
  final Widget targetPage;

  const PageSelectButton(
      {super.key,
      required this.buttonTitle,
      required this.buttonIcon,
      required this.targetPage});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return targetPage;
          }));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          shape: const LinearBorder(),
        ),
        child: SizedBox(
          height: 100,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  buttonTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Icon(
                  buttonIcon,
                  size: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
