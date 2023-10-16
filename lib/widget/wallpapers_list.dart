import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import 'package:wallpaper/screens/image_detail.dart';
import '../models/wallpaper_model.dart';

Widget wallpapersList({
  required List<WallpaperModel> wallpapers,
  context,
  required ScrollController scrollController,
}) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: ScrollConfiguration(
          behavior: const ScrollBehavior(androidOverscrollIndicator: AndroidOverscrollIndicator.stretch),
         child : GridView.builder(
            shrinkWrap: true,
            controller: scrollController,
            itemCount: wallpapers.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              if (index == wallpapers.length - 1) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                WallpaperModel wallpaper = wallpapers[index];
                return GridTile(
                  child: Stack(
                    children: [
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(int.parse('0xFF${wallpaper.avgColor?.substring(1)}')),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: CachedNetworkImage(
                            imageUrl: wallpaper.src!.portrait,
                            fit: BoxFit.cover,
                            fadeInDuration: const Duration(milliseconds: 300),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            )),
                        child: Container(),
                        onPressed: () {
                          HapticFeedback.vibrate();
                          Future.delayed(const Duration(milliseconds: 100), () {
                            Navigator.push(
                              context,
                              SwipeablePageRoute(
                                builder: (context) =>
                                    ImageDetail(
                                  imgUrl: wallpaper.src!.portrait,
                                  originalUrl: wallpaper.src!.original,
                                  photographer: wallpaper.photographer!,
                                  photographerUrl: wallpaper.photographerUrl!,
                                  imageHeight: wallpaper.imageHeight!,
                                  imageWidth: wallpaper.imageWidth!,
                                ),
                              ),
                            );
                          });
                        },
                      ),
                        Positioned(
                        left: 5,
                        bottom: 5,
                        child: Text(
                          // "data",
                          wallpaper.photographer!,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontSize: 15
                          ),
                        ),
                      ),
                      Positioned(
                        right: 5,
                        top: 5,
                        child: GestureDetector(
                          onTap: () => {

                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.favorite_outline,
                              color: Color(0xffd84354),
                              size: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          ),
    ),
  );
}
