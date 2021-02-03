import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/screens/Landing/landing_services.dart';
import 'package:social_media_app/services/firebase_operations.dart';

class LandingUtils with ChangeNotifier {
  final picker = ImagePicker();
  File userAvatar;
  File get getUserAvatar => userAvatar;
  String userAvatarUrl;
  String get getuserAvatarUrl => userAvatarUrl;

  Future pickUserAvatar(BuildContext context, ImageSource source) async {
    final pickedUserAvatar =
        await picker.getImage(source: source, imageQuality: 80);
    pickedUserAvatar == null
        ? print("Select Image")
        : userAvatar = File(pickedUserAvatar.path);
    print(userAvatar.path);

    userAvatar != null
        ? Provider.of<LandingService>(context, listen: false)
            .showUserAvatar(context)
        : print("Image upload error");

    notifyListeners();
  }

  Future selectAvatarOptionsSheet(BuildContext context) async {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150),
                  child: Divider(
                    thickness: 4.0,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20),
                  child: Text(
                    "Select Image From:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        height: 50,
                        minWidth: MediaQuery.of(context).size.width / 2.2,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.yellow[900]),
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          "Gallery",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          pickUserAvatar(context, ImageSource.gallery)
                              .whenComplete(() {
                            Navigator.pop(context);
                            Provider.of<LandingService>(context, listen: false)
                                .showUserAvatar(context);
                          });
                        },
                      ),
                      MaterialButton(
                        height: 50,
                        minWidth: MediaQuery.of(context).size.width / 2.2,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.blue[900]),
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          "Camera",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          pickUserAvatar(context, ImageSource.camera)
                              .whenComplete(() {
                            Navigator.pop(context);
                            Provider.of<LandingService>(context, listen: false)
                                .showUserAvatar(context);
                          });
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.30,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
          );
        });
  }
}
