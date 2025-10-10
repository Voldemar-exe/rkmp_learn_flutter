import 'package:flutter/material.dart';

class TestListingWidgetScreen extends StatelessWidget {
  const TestListingWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 1; i <= 50; i++) ...[
              Text("Нилов Владимир Владимирович"),
              Text("ИКБО-06-22"),
              Text("22И1745"),
            ],
          ],
        ),
      ),
    );
  }
}
