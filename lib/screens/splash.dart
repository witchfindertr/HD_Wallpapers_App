import 'package:flutter/material.dart';

import 'home.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff191e31),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/icons/ic_logo_1.png',
              ),
            ),
            Container(
              color: Colors.transparent,
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                    const Color.fromRGBO(100, 100, 100, 0.4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18))),
                onPressed: () {
                  Future.delayed(const Duration(milliseconds: 150), () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Home()
                        ));
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18)),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(12),
                  height: 50,
                  child: const Text(
                    'Move on',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
