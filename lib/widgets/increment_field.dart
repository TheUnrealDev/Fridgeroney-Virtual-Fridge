import 'package:flutter/material.dart';

class IncrementField extends StatefulWidget {
  final int initialValue;
  final int stepSize;
  final int? minValue;
  final int? maxValue;
  final Function onChangeFunction;
  const IncrementField({
    super.key,
    required this.onChangeFunction,
    this.initialValue = 0,
    this.stepSize = 1,
    this.minValue,
    this.maxValue,
  });

  @override
  State<IncrementField> createState() => _IncrementFieldState();
}

class _IncrementFieldState extends State<IncrementField> {
  int counter = 0;
  bool initialized = false;

  int limitToRange(int number, int? min, int? max) {
    if (min != null && number < min) {
      return min;
    }
    if (max != null && number > max) {
      return max;
    }
    return number;
  }

  void increment(int direction) {
    int newVal = counter + direction * widget.stepSize;
    newVal = limitToRange(newVal, widget.minValue, widget.maxValue);

    if (newVal == counter) {
      return;
    }
    setState(() {
      counter = newVal;
      widget.onChangeFunction(counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!initialized) {
      setState(() {
        initialized = true;
        counter = widget.initialValue;
      });
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            increment(-1);
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
          ),
          child: const Text(
            "-",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          counter.toString(),
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
        ),
        ElevatedButton(
          onPressed: () {
            increment(1);
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
          ),
          child: const Text(
            "+",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
