import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/screens/ChatRoom/chatroom.dart';
import 'package:social_media_app/screens/Feed/feed.dart';
import 'package:social_media_app/screens/Homepage/homepagehelpers.dart';
import 'package:social_media_app/screens/Profile/profile.dart';
import 'package:social_media_app/services/firebase_operations.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController homepageController = PageController();
  int pageIndex = 0;

  @override
  void initState() {
    Provider.of<FirebaseOperations>(context, listen: false)
        .initUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: homepageController,
          children: [
            Feed(),
            ChatRoom(),
            Profile(),
          ],
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (page) {
            setState(() {
              pageIndex = page;
            });
          },
        ),
        bottomNavigationBar:
            Provider.of<HomePageHelpers>(context, listen: false)
                .bottomNavBar(context, pageIndex, homepageController));
  }
}
