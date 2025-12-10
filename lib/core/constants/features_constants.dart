import 'package:flutter/material.dart';

class FeaturesConstants {
  static const String auth = 'auth';
  static const List<Map<String, dynamic>> onHomeFeatures = [
    {'title': 'Рецепты', 'icon': Icons.restaurant, 'route': '/home/recipes'},
    {
      'title': 'Ингредиенты',
      'icon': Icons.kitchen,
      'route': '/home/ingredients',
    },
    {
      'title': 'Расписание',
      'icon': Icons.calendar_today,
      'route': '/home/schedule',
    },
    {
      'title': 'Статистика',
      'icon': Icons.bar_chart,
      'route': '/home/statistics',
    },
    {'title': 'Профиль', 'icon': Icons.person, 'route': '/home/profile'},
    {'title': 'Настройки', 'icon': Icons.settings, 'route': '/home/settings'},
  ];
}
