import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TestImagesWidget extends StatelessWidget {
  TestImagesWidget({super.key});

  final List<String> imageUrls = [
    'https://cataas.com/cat/black',
    'https://cataas.com/cat/orange',
    'https://cataas.com/cat/white',
    'https://cataas.com/cat/brown',
    'https://cataas.com/cat/cute',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Изображения')),
      body: ListView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CachedNetworkImage(
              imageUrl: imageUrls[index],
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.scaleDown,
              height: 200,
            ),
          );
        },
      ),
    );
  }
}