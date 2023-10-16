import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper/widget/app_bar_name.dart';
import '../data/data.dart';
import '../models/wallpaper_model.dart';
import '../widget/wallpapers_list.dart';


class CategoryImages extends StatefulWidget {
  final String categoryName;
  const CategoryImages({
    super.key,
    required this.categoryName,
  });
  @override
  State<CategoryImages> createState() => _CategoryImagesState();
}
class _CategoryImagesState extends State<CategoryImages> {
  final ScrollController _scrollController = ScrollController();
  List<WallpaperModel> wallpapers = [];
  int currentPage = 1;

  getCategoryWallpapers(String query) async {
    var response = await http.get(
      Uri.parse(
          'https://api.pexels.com/v1/search?query=$query&per_page=26&page=1'),
      headers: {"Authorization": apiKey},
    );

    if (kDebugMode) {
      print(response.body.toString());
    }

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      if (kDebugMode) {
        print(element);
      }
      WallpaperModel wallpaperModel = WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {});
  }

  void fetchMoreCategoryWallpapers(String query) async {
    var response = await http.get(
      Uri.parse(
          'https://api.pexels.com/v1/search?query=$query&per_page=26&page=$currentPage'),
      headers: {"Authorization": apiKey},
    );

    if (kDebugMode) {
      print(response.body.toString());
    }

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      if (kDebugMode) {
        print(element);
      }
      WallpaperModel wallpaperModel = WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {});
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      currentPage++;
      fetchMoreCategoryWallpapers(widget.categoryName);
    }
  }

  @override
  void initState() {
    getCategoryWallpapers(widget.categoryName);
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff191e31),
        title: Container(
            alignment: Alignment.bottomCenter,
            child:  appBarName(context, widget.categoryName.substring(0, 1).toUpperCase() + widget.categoryName.substring(1)),
        ),
        elevation: 0.0,
        scrolledUnderElevation: 0,
      ),
      body: Container(
        color:  const Color(0xff191e31),
        child: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xffE9E9E9),
                    borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                margin: const EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
            wallpapersList(
                wallpapers: wallpapers,
                context: context,
                scrollController: _scrollController),
          ],
        ),
      ),
    );
  }
}
