// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_typing_uninitialized_variables, sized_box_for_whitespace, unused_local_variable

import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper_hub/views/popover.dart';

class ImageView extends StatefulWidget {
  final String imgUrl;
  ImageView({required this.imgUrl});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  var filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.imgUrl,
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  widget.imgUrl,
                  fit: BoxFit.cover,
                )),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // set wallpaper button

                GestureDetector(
                  onTap: () {
                    handleButton();
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: const Color(0xff1C1B1B).withOpacity(0.8),
                            borderRadius: BorderRadius.circular(30)),
                        width: MediaQuery.of(context).size.width / 2,
                        height: 50,
                      ),
                      Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width / 2,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white54, width: 1),
                              borderRadius: BorderRadius.circular(30),
                              gradient: const LinearGradient(colors: [
                                Color(0x36FFFFFF),
                                Color(0x0FFFFFFF)
                              ])),
                          child: Column(
                            children: const [
                              Text(' Set Wallpaper',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white70)),
                              Text(
                                'Image will be set as wallpaper',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white70),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),

                // cancel button

                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.black45),
                        height: 32,
                        width: MediaQuery.of(context).size.width / 6,
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white70),
                        ))),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),

          // download image button

          Positioned(
            top: 35,
            right: 10,
            child: IconButton(
                onPressed: () {
                  Fluttertoast.showToast(
                      msg: 'Image downloaded!',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 2,
                      textColor: Colors.white,
                      fontSize: 14,
                      backgroundColor: Colors.black87);
                  _save();
                },
                icon: Icon(
                  Icons.download_for_offline_sharp,
                  color: Colors.white,
                  size: 35,
                )),
          )
        ],
      ),
    );
  }

// downoald image to gallery

  _save() async {
    await _askPermission();
    var response = await Dio()
        .get(widget.imgUrl, options: Options(responseType: ResponseType.bytes));
    final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }

  _askPermission() async {
    if (Platform.isIOS) {
      Map<Permission, PermissionStatus> permissions =
          await [Permission.photos].request();
    } else {
      PermissionStatus permission = await Permission.storage.status;
    }
  }

// set home wallpaper

  Future<void> setHomeWallpaper() async {
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imgUrl);
    bool result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

// set lock wallpaper

  Future<void> setLockWallpaper() async {
    int location = WallpaperManager.LOCK_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imgUrl);
    bool result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

// set both wallpaper

  Future<void> setBothWallpaper() async {
    int location = WallpaperManager.BOTH_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imgUrl);
    bool result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

// set wallpaper button handler

  void handleButton() {
    showModalBottomSheet<int>(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Popover(
              child: Column(
            children: [
              GestureDetector(
                onTap: setHomeWallpaper,
                child: buildListItem(context,
                    title: 'Home Screen',
                    leading: const Icon(Icons.phone_android)),
              ),
              GestureDetector(
                onTap: setLockWallpaper,
                child: buildListItem(context,
                    title: 'Lock Screen',
                    leading: const Icon(Icons.screen_lock_portrait)),
              ),
              GestureDetector(
                onTap: setBothWallpaper,
                child: buildListItem(context,
                    title: 'Both Screen',
                    leading: const Icon(Icons.content_copy)),
              ),
            ],
          ));
        });
  }

// popover list

  Widget buildListItem(
    BuildContext context, {
    String? title,
    Widget? leading,
  }) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: theme.dividerColor, width: 0.5))),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (leading != null) leading,
          if (title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                title,
                style: theme.textTheme.headline4,
              ),
            ),
          const Spacer(),
        ],
      ),
    );
  }
}
