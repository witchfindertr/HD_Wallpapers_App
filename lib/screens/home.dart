import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:wallpaper/data/colors_app.dart';
import 'package:wallpaper/screens/search.dart';
import 'package:wallpaper/widget/categories_list.dart';
import '../data/data.dart';
import '../models/category.model.dart';
import '../models/wallpaper_model.dart';
import '../widget/app_bar_name.dart';
import '../widget/category_item_home.dart';
import '../widget/wallpapers_list.dart';
import 'package:flutter_offline/flutter_offline.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  List<CategoryModel> categories = [];
  List<WallpaperModel> wallpapers = [];
  List<String> data = ["Home", "Categories", "Favorites", "Popular"];
  TextEditingController searchController = TextEditingController();
  int _currentIndex = 0;
  int currentPage = 1;
  final PageController _pageController = PageController(initialPage: 0);

  getTrendingWallpapers() async {
    var response = await http.get(
      Uri.parse('https://api.pexels.com/v1/curated?per_page=26&page=1'),
      headers: {"Authorization": apiKey},
    );

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      WallpaperModel wallpaperModel = WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });
    setState(() {});
  }

  void fetchMoreWallpapers() async {
    var response = await http.get(
      Uri.parse(
          'https://api.pexels.com/v1/curated?per_page=26&page=$currentPage'),
      headers: {"Authorization": apiKey},
    );

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
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
      fetchMoreWallpapers();
    }
  }

  @override
  void initState() {
    getTrendingWallpapers();
    categories = getCategories();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
             SizedBox(
              height: MediaQuery.of(context).size.height/3.5,
            ),
            const Text(
              'Can\'t connect .. check internet',
              style: TextStyle(
                fontSize: 22,
                color: AppColors.secundary,
              ),
            ),
            Image.asset('assets/images/no_internet.png')
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    Widget collections = Column(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ScrollConfiguration(
              behavior: const ScrollBehavior(
                  androidOverscrollIndicator:
                      AndroidOverscrollIndicator.stretch),
              child: GridView.builder(
                shrinkWrap: true,
                controller: _scrollController,
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 2,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  return CategoriesList(
                    title: categories[index].categoryName,
                    imgUrl: categories[index].imgUrl,
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );

    Widget curated = ScrollConfiguration(
      behavior: const ScrollBehavior(androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black12,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          if (kDebugMode) {
                            print("Search ${searchController.text}");
                          }
                          Navigator.push(
                            context,
                            SwipeablePageRoute(
                              builder: (context) => Search(
                                searchQuery: searchController.text,
                              ),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      if (kDebugMode) {
                        print("Search $value");
                      }
                      Navigator.push(
                        context,
                        SwipeablePageRoute(
                          builder: (context) => Search(
                            searchQuery: searchController.text,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 45,
            child: ScrollConfiguration(
              behavior: const ScrollBehavior(
                  androidOverscrollIndicator:
                      AndroidOverscrollIndicator.stretch),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                itemCount: 5,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CategoryItem(
                    title: categories[index].categoryName,
                  );
                  // return Container();
                },
              ),
            ),
          ),
          OfflineBuilder(
              connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child ,)
              {
                final bool connected = connectivity != ConnectivityResult.none;
                if (connected) {
                  return wallpapersList(
                    wallpapers: wallpapers,
                    context: context,
                    scrollController: _scrollController,
                  );
                } else {
                  return buildNoInternetWidget();
                }
              },
              builder: (BuildContext ctx) {
                return Container();
              },

          ),
        ],
      ),
    );

    Widget favorites = Column(
      children: [
        OfflineBuilder(
          connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child ,)
          {
            final bool connected = connectivity != ConnectivityResult.none;
            if (connected) {
              return wallpapersList(
                wallpapers: wallpapers,
                context: context,
                scrollController: _scrollController,
              );
            } else {
              return buildNoInternetWidget();
            }
          },
          builder: (BuildContext ctx) {
            return Container();
          },

        ),
      ],
    );
    Widget popular = Column(
      children: [
        OfflineBuilder(
          connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child ,)
          {
            final bool connected = connectivity != ConnectivityResult.none;
            if (connected) {
              return wallpapersList(
                wallpapers: wallpapers,
                context: context,
                scrollController: _scrollController,
              );
            } else {
              return buildNoInternetWidget();
            }
          },
          builder: (BuildContext ctx) {
            return Container();
          },

        )
      ],
    );
    return Scaffold(
      backgroundColor: Color(0xff191e31),
      appBar: AppBar(
        backgroundColor: Color(0xff191e31),
        title: appBarName(context, data[_currentIndex]),
        elevation: 0.0,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [curated, collections, favorites, popular],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xff191e31),
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_rounded, color: Colors.white),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_rounded, color: Colors.white),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            icon:
                Icon(Icons.local_fire_department_rounded, color: Colors.white),
            label: "Popular",
          ),
        ],
        onTap: (index) {
          _pageController.animateToPage(index,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut);
        },
      ),
    );
  }
}
