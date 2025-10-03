import 'package:flutter/material.dart';

class TestWidgetScreen extends StatelessWidget {
  const TestWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          "Нилов Владимир Владимирович\nИКБО-06-22\n22И1745",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
      ),
    );
  }
}
