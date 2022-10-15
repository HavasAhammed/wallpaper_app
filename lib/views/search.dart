// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, avoid_unnecessary_containers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_hub/data/data.dart';
import 'package:wallpaper_hub/model/wallpaper_model.dart';
import 'package:wallpaper_hub/theme/theme_provider.dart';
import 'package:wallpaper_hub/widgets/widgets.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  String searchQuery;
  Search({required this.searchQuery});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isLoading = true;
  final TextEditingController _searchController = TextEditingController();
  List<WallpaperModel> wallpapers = [];

  getSearchWallpapers(String query) async {
    var response = await http.get(
        Uri.parse(
          "https://api.pexels.com/v1/search?query=$query&per_page=80&page=1",
        ),
        headers: {'Authorization': apiKey});

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      wallpapers.clear();
      jsonData['photos'].forEach((element) {
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
    getSearchWallpapers(widget.searchQuery);
    super.initState();
    _searchController.text = widget.searchQuery;
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: brandName(context),
        actions: const [
          SizedBox(
            width: 50,
          )
        ],
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
                        getSearchWallpapers(_searchController.text);
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
      ),
    );
  }
}
