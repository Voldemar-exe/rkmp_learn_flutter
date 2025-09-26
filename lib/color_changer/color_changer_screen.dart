import 'package:flutter/material.dart';

class ColorChangerScreen extends StatefulWidget {
  const ColorChangerScreen({super.key});

  @override
  State<ColorChangerScreen> createState() => _ColorChangerScreenState();
}

class _ColorChangerScreenState extends State<ColorChangerScreen> {
  Color _backgroundColor = Colors.white;

  void _changeToRed() {
    setState(() {
      _backgroundColor = Colors.red;
    });
  }

  void _changeToBlue() {
    setState(() {
      _backgroundColor = Colors.blue;
    });
  }

  void _changeToGreen() {
    setState(() {
      _backgroundColor = Colors.green;
    });
  }

  void _resetColor() {
    setState(() {
      _backgroundColor = Colors.white;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Смена цвета фона'),
      ),
      body: Container(
        color: _backgroundColor,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Нажмите на кнопку, чтобы изменить цвет фона',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _changeToRed,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text('Красный', style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: _changeToBlue,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: Text('Синий', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _changeToGreen,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: Text('Зеленый', style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: _resetColor,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    child: Text('Сброс', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Назад на главную'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}