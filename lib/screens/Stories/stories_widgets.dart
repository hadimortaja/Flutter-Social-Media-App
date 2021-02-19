import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/screens/Homepage/homepage.dart';
import 'package:social_media_app/screens/Stories/stories_helper.dart';
import 'package:social_media_app/services/authentication.dart';
import 'package:social_media_app/services/firebase_operations.dart';

class StoryWidgets {
  previewStoryImage(BuildContext context, File storyImage) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Image.file(storyImage),
                ),
                Positioned(
                    top: 500,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FloatingActionButton(
                              heroTag: "Reselect Image",
                              backgroundColor: Colors.grey,
                              child: Icon(
                                Icons.backspace,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                addStory(context);
                              }),
                          FloatingActionButton(
                              heroTag: "Confirm Image",
                              backgroundColor: Colors.blue,
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Provider.of<StoriesHelper>(context,
                                        listen: false)
                                    .uploadStoryImage(context)
                                    .whenComplete(() async {
                                  try {
                                    if (Provider.of<StoriesHelper>(context,
                                                listen: false)
                                            .getStoryImageUrl !=
                                        null) {
                                      await FirebaseFirestore.instance
                                          .collection('stories')
                                          .doc(Provider.of<Authentication>(
                                                  context,
                                                  listen: false)
                                              .getUserUid)
                                          .set({
                                        'image': Provider.of<StoriesHelper>(
                                                context,
                                                listen: false)
                                            .getStoryImageUrl,
                                        'username':
                                            Provider.of<FirebaseOperations>(
                                                    context,
                                                    listen: false)
                                                .getinitUserName,
                                        'userimage':
                                            Provider.of<FirebaseOperations>(
                                                    context,
                                                    listen: false)
                                                .getinitUserImage,
                                        'time': Timestamp.now(),
                                        'useruid': Provider.of<Authentication>(
                                                context,
                                                listen: false)
                                            .getUserUid,
                                      }).whenComplete(() {
                                        Navigator.pushReplacement(
                                            context,
                                            PageTransition(
                                                child: HomePage(),
                                                type: PageTransitionType
                                                    .leftToRight));
                                      });
                                    } else {
                                      return showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.black),
                                                child: Center(
                                                    child: MaterialButton(
                                                  onPressed: () async {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection('stories')
                                                        .doc(Provider.of<
                                                                    Authentication>(
                                                                context,
                                                                listen: false)
                                                            .getUserUid)
                                                        .set({
                                                      'image': Provider.of<
                                                                  StoriesHelper>(
                                                              context,
                                                              listen: false)
                                                          .getStoryImageUrl,
                                                      'username': Provider.of<
                                                                  FirebaseOperations>(
                                                              context,
                                                              listen: false)
                                                          .getinitUserName,
                                                      'userimage': Provider.of<
                                                                  FirebaseOperations>(
                                                              context,
                                                              listen: false)
                                                          .getinitUserImage,
                                                      'time': Timestamp.now(),
                                                      'useruid': Provider.of<
                                                                  Authentication>(
                                                              context,
                                                              listen: false)
                                                          .getUserUid,
                                                    }).whenComplete(() {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          PageTransition(
                                                              child: HomePage(),
                                                              type: PageTransitionType
                                                                  .leftToRight));
                                                    });
                                                  },
                                                  child: Text("Upload Story !"),
                                                )));
                                          });
                                    }
                                  } catch (e) {
                                    print(e.toString());
                                  }
                                });
                              })
                        ],
                      ),
                    ))
              ],
            ),
          );
        });
  }

  addStory(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 150),
                  child: Divider(
                    thickness: 4,
                    color: Colors.black,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                        child: Text(
                          'Gallery',
                        ),
                        onPressed: () {
                          Provider.of<StoriesHelper>(context, listen: false)
                              .selectStoryImage(context, ImageSource.gallery)
                              .whenComplete(() {
                            // Navigator.pop(context);
                          });
                        }),
                    MaterialButton(
                        child: Text(
                          'Camera',
                        ),
                        onPressed: () {
                          Provider.of<StoriesHelper>(context, listen: false)
                              .selectStoryImage(context, ImageSource.camera)
                              .whenComplete(() {
                            Navigator.pop(context);
                          });
                        })
                  ],
                )
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
          );
        });
  }
}
