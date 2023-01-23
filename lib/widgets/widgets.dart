import 'package:flutter/material.dart';
import 'package:wallpaper_hub/model/wallpaper_model.dart';
import 'package:wallpaper_hub/views/image_view.dart';

Widget brandName(BuildContext context) {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Wallpaper',
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(
          width: 5,
        ),
        Container(
          height: 26,
          width: 48,
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: Text(
              'Hub',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget wallpaperList({required List<WallpaperModel> wallpapers, context}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
        children: wallpapers.map((wallpaper) {
          return GridTile(
              child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImageView(
                          imgUrl: wallpaper.src!.portrait.toString())));
            },
            child: Hero(
              tag: wallpaper.src!.portrait.toString(),
              // ignore: avoid_unnecessary_containers
              child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      wallpaper.src!.portrait.toString(),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ));
        }).toList()),
  );
}
