import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: Colors.grey[300],
              child: const Icon(
                Icons.person,
                size: 60,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Нилов Владимир Владимирович',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Студент группы ИКБО-06-22',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 5),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: const [
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text('i@voldemarexe.ru'),
                    ),
                    ListTile(
                      leading: Icon(Icons.school),
                      title: Text('22И1745'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}