import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/constants/constant_color.dart';
import 'package:social_media_app/screens/Landing/landing_helper.dart';
import 'package:social_media_app/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ConstantColors constantColors = ConstantColors();
    return MultiProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              accentColor: constantColors.blueColor,
              fontFamily: 'Poppins',
              canvasColor: Colors.transparent),
          home: SplashScreen(),
        ),
        providers: [ChangeNotifierProvider(create: (_) => LandingHelpers())]);
  }
}
