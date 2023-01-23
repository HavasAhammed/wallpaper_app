// ignore_for_file: unused_local_variable, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wallpaper_hub/data/data.dart';
import 'package:wallpaper_hub/model/categories_model.dart';
import 'package:wallpaper_hub/model/wallpaper_model.dart';
import 'package:wallpaper_hub/theme/theme_provider.dart';
import 'package:wallpaper_hub/views/search.dart';
import 'package:wallpaper_hub/widgets/categories_tile_widget.dart';
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
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  themeChange.darkTheme = !themeChange.darkTheme;
                },
                icon: themeChange.darkTheme
                    ? const Icon(Icons.bedtime)
                    : const Icon(Icons.wb_sunny))
          ],
          centerTitle: true,
          title: brandName(context),
        ),
        body: Column(
          children: [
            // search field

            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: themeChange.darkTheme
                      ? const Color.fromARGB(255, 208, 214, 224)
                      : const Color.fromARGB(255, 29, 39, 38)),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                          color: themeChange.darkTheme
                              ? Colors.black
                              : Colors.white),
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
                          ? Colors.black54
                          : Colors.white60,
                    )),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),

            // category list

            Expanded(
              child: ListView(
                children: [
                  Container(
                    height: 80,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return CategoriesTileWidget(
                          title: categories[index].categoriesName.toString(),
                          imageUrl: categories[index].imageUrl,
                        );
                      },
                    ),
                  ),

                  // wallpaper list

                  isLoading
                      ? SpinKitFadingCircle(
                          color: themeChange.darkTheme
                              ? Colors.black
                              : Colors.white,
                        )
                      : wallpaperList(wallpapers: wallpapers, context: context),
                ],
              ),
            )
          ],
        ));
  }
}
