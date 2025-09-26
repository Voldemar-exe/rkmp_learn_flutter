import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(
                Icons.app_registration,
                size: 60,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Практическая работа 3',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Версия 0.0.1',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Это учебное приложение, разработанное для выполнения практической работы по дисциплине "Разработка кроссплатформенных мобильных приложений".',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
