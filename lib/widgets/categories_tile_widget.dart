import 'package:flutter/material.dart';
import 'package:wallpaper_hub/views/category.dart';

class CategoriesTileWidget extends StatelessWidget {
  final String? imageUrl;
  final String title;
  CategoriesTileWidget({this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Categories(categoriesName: title)));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 4),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imageUrl.toString(),
                height: 50,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              height: 50,
              width: 100,
              child: Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
