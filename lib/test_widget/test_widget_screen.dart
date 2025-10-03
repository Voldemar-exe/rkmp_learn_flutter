import 'package:flutter/material.dart';

class TestWidgetScreen extends StatelessWidget {
  const TestWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(32.0),
              child: Text(
                "Нилов Владимир Владимирович\nИКБО-06-22\n22И1745",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
            ),
            SizedBox(width: 200),
            Container(
              padding: EdgeInsets.all(32.0),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(50)
              ),
              child: ElevatedButton(
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
            ),
          ],
        ),
      ),
    );
  }
}
