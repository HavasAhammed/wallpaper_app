// ignore_for_file: unused_local_variable, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wallpaper_hub/data/data.dart';
import 'package:wallpaper_hub/model/categories_model.dart';
import 'package:wallpaper_hub/model/wallpaper_model.dart';
import 'package:wallpaper_hub/theme/theme_provider.dart';
import 'package:wallpaper_hub/views/categor.dart';
import 'package:wallpaper_hub/views/search.dart';
import 'package:wallpaper_hub/widgets/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;

  List<CategoriesModel> categories = [];

  List<WallpaperModel> wallpapers = [];

  final TextEditingController _searchController = TextEditingController();

  Future<WallpaperModel> getTrendingWallpapers() async {
    var response = await http.get(
        Uri.parse(
          "https://api.pexels.com/v1/curated?per_page=80&page=1",
        ),
        headers: {'Authorization': apiKey});

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      jsonData['photos'].forEach((element) {
        WallpaperModel wallpaperModel = WallpaperModel();
        wallpaperModel = WallpaperModel.fromMap(element);
        wallpapers.add(wallpaperModel);
      });

      setState(() {
        isLoading = false;
      });
      return WallpaperModel.fromMap(jsonData);
    } else {
      throw Exception('Error');
    }
  }

  @override
  void initState() {
    getTrendingWallpapers();
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<ThemeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  themeChange.darkTheme = !themeChange.darkTheme;
                },
                icon: themeChange.darkTheme
                    ? const Icon(Icons.bedtime)
                    : const Icon(Icons.wb_sunny))
          ],
          title: brandName(context),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: themeChange.darkTheme
                          ? const Color.fromARGB(255, 29, 39, 38)
                          : const Color.fromARGB(255, 208, 214, 224)),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: TextStyle(
                              color: themeChange.darkTheme
                                  ? Colors.white
                                  : Colors.black),
                          controller: _searchController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'search wallpaper',
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Search(
                                        searchQuery: _searchController.text,
                                      )));
                        },
                        child: Container(
                            child: Icon(
                          Icons.search,
                          color: themeChange.darkTheme
                              ? Colors.white60
                              : Colors.black54,
                        )),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  height: 80,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoriesTile(
                        title: categories[index].categoriesName.toString(),
                        imageUrl: categories[index].imageUrl,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                isLoading
                    ? SpinKitFadingCircle(
                        color:
                            themeChange.darkTheme ? Colors.white : Colors.black,
                      )
                    : wallpaperList(wallpapers: wallpapers, context: context)
              ],
            ),
          ),
        ));
  }
}

class CategoriesTile extends StatelessWidget {
  final String? imageUrl;
  final String title;
  CategoriesTile({this.imageUrl, required this.title});

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
