import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:share_plus/share_plus.dart';

class ImageDetail extends StatefulWidget {
  final String imgUrl;
  final String originalUrl;
  final String photographer;
  final String photographerUrl;
  final String imageHeight;
  final String imageWidth;
  const ImageDetail({
    super.key,
    required this.imgUrl,
    required this.originalUrl,
    required this.photographer,
    required this.photographerUrl,
    required this.imageHeight,
    required this.imageWidth,
  });

  @override
  State<ImageDetail> createState() => _ImageDetailState();
}

class _ImageDetailState extends State<ImageDetail> {
  bool _downloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff191e31),
      appBar: AppBar(
        backgroundColor: Color(0xff191e31),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Future.delayed(
                const Duration(
                    milliseconds:
                    150), () {
              Navigator.of(context)
                  .pop();
            });
          },
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('Option 1'),
                  value: 'option1',
                ),
              ];
            },
            onSelected: (value) {},
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(bottom: 60.0),
            child: FutureBuilder(
              future: Future.delayed(const Duration(milliseconds: 500)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CachedNetworkImage(
                    imageUrl: widget.originalUrl,
                    fit: BoxFit.cover,
                    fadeInDuration: const Duration(seconds: 0),
                    placeholder: (context, url) => CachedNetworkImage(
                      imageUrl: widget.imgUrl,
                      fit: BoxFit.cover,
                      fadeInDuration: const Duration(seconds: 0),
                    ),
                  );
                } else {
                  return CachedNetworkImage(
                    imageUrl: widget.imgUrl,
                    fit: BoxFit.cover,
                    fadeInDuration: const Duration(seconds: 0),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28)),
                            color: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
                          ),
                          height: MediaQuery.of(context).size.height / 2.95,
                          padding: const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 18,
                                child: Text('Choose quality', style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 14,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
                                      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.white24 : Colors.black38,
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(25), topLeft: Radius.circular(25), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)))),
                                  onPressed: () {
                                    Future.delayed(
                                        const Duration(milliseconds: 150), () {
                                      _save();
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Text('High Quality', style: TextStyle(color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 14,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white,
                                      backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.white24 : Colors.black38,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                  onPressed: () {
                                    Future.delayed(
                                        const Duration(milliseconds: 150), () {
                                      Navigator.pop(context);
                                      _saveOriginal();
                                    });
                                  },
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Text('Original Quality', style: TextStyle(color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    child: Icon(
                      Icons.download,
                      color: Color(0xffd84354),
                      size: 30,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => {},
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    child: const Icon(
                      Icons.wallpaper,
                      color: Color(0xffd84354),
                      size: 30,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => {},
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Color(0xffd84354),
                      size: 30,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => {
                    Future.delayed(const Duration(milliseconds: 150), () {
                      Navigator.pop(context);
                      _shareWallpaper();
                    })
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    child: const Icon(
                      Icons.share,
                      color: Color(0xffd84354),
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _downloading
              ? Container(
            alignment: Alignment.bottomCenter,
            child: const LinearProgressIndicator(
              backgroundColor: Colors.black,
              color: Colors.white,
            ),
          )
              : Container(),
        ],
      ),
    );
  }


  _save() async {
    setState(() {
      _downloading = true;
    });
    var permissionStatus = await _askPermission();

    if (permissionStatus) {
      var downloadUrl = widget.imgUrl;
      var response = await Dio()
          .get(downloadUrl, options: Options(responseType: ResponseType.bytes));
      final result =
      await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));

      setState(() {
        _downloading = false;
      });

      if (result['isSuccess'] == true) {
        SnackBar snackBar = const SnackBar(
          content: Text(
            "Image Saved",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        );
        if (!mounted) return;
        HapticFeedback.vibrate();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  _saveOriginal() async {
    setState(() {
      _downloading = true;
    });
    var permissionStatus = await _askPermission();

    if (permissionStatus) {
      var downloadUrl = widget.originalUrl;
      var response = await Dio().get(
        downloadUrl,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );
      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
      );

      setState(() {
        _downloading = false;
      });

      if (result['isSuccess'] == true) {
        SnackBar snackBar = const SnackBar(
          content: Text(
            "Image Saved",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        );

        if (!mounted) return;
        HapticFeedback.vibrate();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  void _shareWallpaper() async {
    setState(() {
      _downloading = true;
    });

    String imageUrl = widget.originalUrl;
    var status = await Permission.photos.request();
    if (status.isGranted) {
      var file = await DefaultCacheManager().getSingleFile(imageUrl);

      String path = file.path;

      await Share.shareFiles([path]);

      HapticFeedback.vibrate();

      setState(() {
        _downloading = false;
      });
    } else {
      throw Exception('Permission denied');
    }
  }
  _askPermission() async {
    if (await Permission.photos
        .request()
        .isGranted ||
        await Permission.storage
            .request()
            .isGranted) {
      return true;
    } else {
      openAppSettings();
    }
  }
}
