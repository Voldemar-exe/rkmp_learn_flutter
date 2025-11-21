import 'package:flutter/material.dart';

class FeaturesConstants {
  static const String auth = 'auth';
  static const List<Map<String, dynamic>> onHomeFeatures = [
    {'title': 'Рецепты', 'icon': Icons.restaurant, 'route': '/recipes'},
    {'title': 'Холодильник', 'icon': Icons.kitchen, 'route': '/ingredients'},
    {
      'title': 'Расписание',
      'icon': Icons.calendar_today,
      'route': '/schedule',
    },
    {'title': 'Статистика', 'icon': Icons.bar_chart, 'route': '/statistics'},
    {'title': 'Профиль', 'icon': Icons.person, 'route': '/profile'},
    {'title': 'Настройки', 'icon': Icons.settings, 'route': '/settings'},
  ];
}