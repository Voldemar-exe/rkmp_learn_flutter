import 'package:flutter/material.dart';

class TestListingWidgetScreen extends StatelessWidget {
  const TestListingWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.separated(
          itemCount: 50,
          itemBuilder: (context, index) {
            final number = index + 1;
            return Column(
              children: [
                Text("$number"),
                Text("Нилов Владимир Владимирович"),
                Text("ИКБО-06-22"),
                Text("22И1745"),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        ),

      ),
    );
  }
}
