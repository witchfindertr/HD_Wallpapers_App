import 'package:flutter/material.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import '../screens/category_images.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  const CategoryItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black38,
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        onPressed: () {
          Future.delayed(const Duration(milliseconds: 100), () {
            Navigator.push(
              context,
              SwipeablePageRoute(
                  builder: (context) =>
                      CategoryImages(categoryName: title.toLowerCase())),
            );
          });
        },
        child: Container(
          alignment: Alignment.center,
          width: 80,
          height: 26,
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
