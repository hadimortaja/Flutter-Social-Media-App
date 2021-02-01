import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/services/firebase_operations.dart';

class HomePageHelpers with ChangeNotifier {
  Widget bottomNavBar(
      BuildContext context, int index, PageController pageController) {
    return CustomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: index,
        bubbleCurve: Curves.bounceIn,
        scaleCurve: Curves.decelerate,
        selectedColor: Colors.blue[900],
        unSelectedColor: Colors.white,
        strokeColor: Colors.blue,
        scaleFactor: 0.5,
        iconSize: 25,
        onTap: (val) {
          index = val;
          pageController.jumpToPage(val);
          notifyListeners();
        },
        items: [
          CustomNavigationBarItem(icon: Icon(Icons.home)),
          CustomNavigationBarItem(icon: Icon(Icons.message_rounded)),
          CustomNavigationBarItem(
              icon: CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.grey,
                  backgroundImage: Provider.of<FirebaseOperations>(context,
                                  listen: false)
                              .getinitUserImage !=
                          null
                      ? NetworkImage(Provider.of<FirebaseOperations>(context,
                              listen: false)
                          .getinitUserImage)
                      : NetworkImage(
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png"))),
          //CustomNavigationBarItem(icon: Icon(Icons.home)),
        ]);
  }
}
