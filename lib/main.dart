import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/constants/constant_color.dart';
import 'package:social_media_app/screens/AltProfile/alt_profile_helpers.dart';
import 'package:social_media_app/screens/ChatRoom/chatroomhelpers.dart';
import 'package:social_media_app/screens/Feed/feedhelpers.dart';
import 'package:social_media_app/screens/Homepage/homepagehelpers.dart';
import 'package:social_media_app/screens/Landing/landing_helper.dart';
import 'package:social_media_app/screens/Landing/landing_services.dart';
import 'package:social_media_app/screens/Landing/landing_utils.dart';
import 'package:social_media_app/screens/Profile/profilehelpers.dart';
import 'package:social_media_app/screens/Splash/splash_screen.dart';
import 'package:social_media_app/services/authentication.dart';
import 'package:social_media_app/services/firebase_operations.dart';
import 'package:social_media_app/utils/postoptions.dart';
import 'package:social_media_app/utils/uploadpost.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ConstantColors constantColors = ConstantColors();
    return MultiProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // theme: ThemeData(
          //     accentColor: constantColors.blueColor,
          //     fontFamily: 'Poppins',
          //     canvasColor: Colors.transparent),
          home: SplashScreen(),
        ),
        providers: [
          ChangeNotifierProvider(create: (_) => ChatRoomHelpers()),
          ChangeNotifierProvider(create: (_) => AltProfileHelpers()),
          ChangeNotifierProvider(create: (_) => PostFunctions()),
          ChangeNotifierProvider(create: (_) => FeedHelpers()),
          ChangeNotifierProvider(create: (_) => UploadPost()),
          ChangeNotifierProvider(create: (_) => ProfileHelpers()),
          ChangeNotifierProvider(create: (_) => HomePageHelpers()),
          ChangeNotifierProvider(create: (_) => LandingUtils()),
          ChangeNotifierProvider(create: (_) => FirebaseOperations()),
          ChangeNotifierProvider(create: (_) => LandingService()),
          ChangeNotifierProvider(create: (_) => Authentication()),
          ChangeNotifierProvider(create: (_) => LandingHelpers())
        ]);
  }
}
