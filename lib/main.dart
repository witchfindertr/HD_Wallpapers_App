import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallpaper/screens/home.dart';
import 'package:wallpaper/screens/splash.dart';
import 'data/colors_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: AppColors.back,
        textTheme: GoogleFonts.poppinsTextTheme(),
        brightness: Brightness.dark,
      ),
      home:
      FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.hasData) {
            SharedPreferences? prefs = snapshot.data;
            bool isFirstRun = prefs?.getBool('isFirstRun') ?? false;
            if (!isFirstRun) {
              prefs?.setBool('isFirstRun', true);
            }
            return isFirstRun ? const Home() : const SplashScreen();
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
      // ),
    );
  }
}
