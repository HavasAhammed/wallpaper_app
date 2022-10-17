// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:wallpaper_hub/data/data.dart';
import 'package:wallpaper_hub/model/wallpaper_model.dart';
import 'package:wallpaper_hub/theme/theme_provider.dart';
import 'package:wallpaper_hub/widgets/widgets.dart';

class Categories extends StatefulWidget {
  final String categoriesName;
  Categories({required this.categoriesName});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  bool isLoading = true;

  List<WallpaperModel> wallpapers = [];
  List<String>gg=[];

  getSearchWallpapers(String query) async {
    var response = await http.get(
        Uri.parse(
          "https://api.pexels.com/v1/search?query=$query&per_page=80&page=1",
        ),
        headers: {'Authorization': apiKey});

    // print(response.body.toString());

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      jsonData['photos'].forEach((element) {
        // print(element);

        WallpaperModel wallpaperModel = WallpaperModel();
        wallpaperModel = WallpaperModel.fromMap(element);
        wallpapers.add(wallpaperModel);
      });

      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Error');
    }
  }

  @override
  void initState() {
    getSearchWallpapers(widget.categoriesName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: brandName(context),
        actions: const [
          SizedBox(
            width: 50,
          )
        ],
      ),
      body: isLoading
          ? SpinKitFadingCircle(
              color: themeChange.darkTheme ? Colors.black : Colors.white,
            )
          : SingleChildScrollView(
              // ignore: avoid_unnecessary_containers
              child: Container(
                child: Column(
                  children: [
                    wallpaperList(wallpapers: wallpapers, context: context)
                  ],
                ),
              ),
            ),
    );
  }
}
