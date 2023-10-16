import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

Widget appBarName(BuildContext context,String name) {
  return Center(
    child: RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          fontFamily: GoogleFonts.ubuntu().fontFamily,
        ),
        children: <TextSpan>[
          TextSpan(
            text: name,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ),
  );
}