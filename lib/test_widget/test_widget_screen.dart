import 'package:flutter/material.dart';

class TestWidgetScreen extends StatelessWidget {
  const TestWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Нилов Владимир Владимирович\nИКБО-06-22\n22И1745",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ),
            ElevatedButton(
              onPressed: null,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.amber),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              child: const Text("Кнопка"),
            ),
          ],
        ),
      ),
    );
  }
}
