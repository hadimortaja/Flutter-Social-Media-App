import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/screens/AltProfile/alt_profile.dart';
import 'package:social_media_app/services/authentication.dart';
import 'package:social_media_app/services/firebase_operations.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostFunctions with ChangeNotifier {
  TextEditingController commentController = TextEditingController();
  TextEditingController updatedCaption = TextEditingController();

  String imageTimePosted;
  String get getImageTimePosted => imageTimePosted;

  showTimeAgo(dynamic timedata) {
    Timestamp time = timedata;
    DateTime dateTime = time.toDate();
    imageTimePosted = timeago.format(dateTime);
    print(imageTimePosted);
    //notifyListeners();
  }

  showPostOptions(BuildContext context, String postId) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150),
                  child: Divider(
                    thickness: 4.0,
                    color: Colors.black,
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        child: Text("Edit Caption "),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 150),
                                        child: Divider(
                                          thickness: 4.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Center(
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 300,
                                              height: 50,
                                              child: TextField(
                                                controller: updatedCaption,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "Add new caption"),
                                              ),
                                            ),
                                            FloatingActionButton(
                                              child: Icon(Icons.file_upload),
                                              onPressed: () {
                                                Provider.of<FirebaseOperations>(
                                                        context,
                                                        listen: false)
                                                    .updateCaption(postId, {
                                                  "caption":
                                                      updatedCaption.text,
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                      ),
                      MaterialButton(
                        child: Text("Delete Post "),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Platform.isIOS
                                    ? CupertinoAlertDialog(
                                        title: Text("Delete This Post?"),
                                        actions: [
                                          CupertinoDialogAction(
                                            isDefaultAction: true,
                                            onPressed: () {
                                              print("you choose no");
                                              Navigator.of(context).pop(false);
                                            },
                                            child: Text('No'),
                                          ),
                                          CupertinoDialogAction(
                                            onPressed: () {
                                              Provider.of<FirebaseOperations>(
                                                      context,
                                                      listen: false)
                                                  .deleteUserData(
                                                      postId, "posts")
                                                  .whenComplete(() {
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: Text(
                                              'Yes',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ],
                                      )
                                    : AlertDialog(
                                        title: Text("Delete This Post?"),
                                        actions: [
                                          FlatButton(
                                            onPressed: () {
                                              print("you choose no");
                                              Navigator.of(context).pop(false);
                                            },
                                            child: Text('No'),
                                          ),
                                          FlatButton(
                                            onPressed: () {
                                              Provider.of<FirebaseOperations>(
                                                      context,
                                                      listen: false)
                                                  .deleteUserData(
                                                      postId, "posts")
                                                  .whenComplete(() {
                                                Navigator.pop(context);
                                              });
                                            },
                                            child: Text('Yes'),
                                          ),
                                        ],
                                      );
                              });
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              color: Colors.white,
            ),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
          );
        });
  }

  Future addLike(BuildContext context, String postId, String subDocId) async {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(subDocId)
        .set({
      'likes': FieldValue.increment(1),
      'username': Provider.of<FirebaseOperations>(context, listen: false)
          .getinitUserName,
      'useruid': Provider.of<Authentication>(context, listen: false).getUserUid,
      'userimage': Provider.of<FirebaseOperations>(context, listen: false)
          .getinitUserImage,
      'useremail': Provider.of<FirebaseOperations>(context, listen: false)
          .getinitUserEmail,
      'time': Timestamp.now()
    });
  }

  Future addComment(BuildContext context, String postId, String comment) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(comment)
        .set({
      'comment': comment,
      'username': Provider.of<FirebaseOperations>(context, listen: false)
          .getinitUserName,
      'useruid': Provider.of<Authentication>(context, listen: false).getUserUid,
      'userimage': Provider.of<FirebaseOperations>(context, listen: false)
          .getinitUserImage,
      'useremail': Provider.of<FirebaseOperations>(context, listen: false)
          .getinitUserEmail,
      'time': Timestamp.now()
    });
  }

  showCommentsSheet(
      BuildContext context, DocumentSnapshot snapshot, String docId) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.75,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150),
                    child: Divider(
                      thickness: 4.0,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        "Comments",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.63,
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('posts')
                          .doc(docId)
                          .collection('comments')
                          .orderBy('time', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return ListView(
                              children: snapshot.data.docs
                                  .map((DocumentSnapshot documentSnapshot) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.17,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, left: 8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            if (documentSnapshot
                                                    .data()['useruid'] !=
                                                Provider.of<Authentication>(
                                                        context,
                                                        listen: false)
                                                    .getUserUid) {
                                              Navigator.pushReplacement(
                                                  context,
                                                  PageTransition(
                                                      child: AltProfile(
                                                        userUid:
                                                            documentSnapshot
                                                                    .data()[
                                                                'useruid'],
                                                      ),
                                                      type: PageTransitionType
                                                          .bottomToTop));
                                            }
                                          },
                                          child: CircleAvatar(
                                            radius: 15,
                                            backgroundColor: Colors.grey,
                                            backgroundImage: NetworkImage(
                                                documentSnapshot
                                                    .data()['userimage']),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Row(
                                              children: [
                                                Text(documentSnapshot
                                                    .data()['username'])
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            IconButton(
                                              icon: Icon(
                                                Icons.arrow_upward,
                                              ),
                                              onPressed: () {},
                                            ),
                                            Text('0'),
                                            IconButton(
                                              icon: Icon(
                                                Icons.replay,
                                              ),
                                              onPressed: () {},
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            size: 13,
                                          ),
                                          onPressed: () {},
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.75,
                                              child: Text(documentSnapshot
                                                  .data()['comment']),
                                            ),
                                            IconButton(
                                              icon: Icon(
                                                Icons.delete,
                                              ),
                                              onPressed: () {},
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black.withOpacity(0.2),
                                  )
                                ],
                              ),
                            );
                          }).toList());
                        }
                      },
                    ),
                  ),
                  Container(
                      width: 400,
                      height: 45,
                      child: Row(
                        children: [
                          Container(
                            width: 344,
                            height: 20,
                            child: TextField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration:
                                  InputDecoration(hintText: "Add Comment..."),
                              controller: commentController,
                            ),
                          ),
                          FloatingActionButton(
                            child: Icon(Icons.comment_outlined),
                            onPressed: () {
                              print("adding comment ..");
                              addComment(context, snapshot.data()['caption'],
                                      commentController.text)
                                  .whenComplete(() {
                                commentController.clear();
                                notifyListeners();
                              });

                              ///
                            },
                          )
                        ],
                      ))
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
            ),
          );
        });
  }

  showLikes(BuildContext context, String postId) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150),
                  child: Divider(
                    thickness: 4.0,
                    color: Colors.black,
                  ),
                ),
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      "Likes",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: 400,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('posts')
                        .doc(postId)
                        .collection('likes')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView(
                            children: snapshot.data.docs
                                .map((DocumentSnapshot documentSnapshot) {
                          return ListTile(
                            leading: GestureDetector(
                                onTap: () {
                                  if (documentSnapshot.data()['useruid'] !=
                                      Provider.of<Authentication>(context,
                                              listen: false)
                                          .getUserUid) {
                                    Navigator.pushReplacement(
                                        context,
                                        PageTransition(
                                            child: AltProfile(
                                              userUid: documentSnapshot
                                                  .data()['useruid'],
                                            ),
                                            type: PageTransitionType
                                                .bottomToTop));
                                  }
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  backgroundImage: NetworkImage(
                                      documentSnapshot.data()['userimage']),
                                )),
                            title: Text(documentSnapshot.data()['username']),
                            subtitle:
                                Text(documentSnapshot.data()['useremail']),
                            trailing: Provider.of<Authentication>(context,
                                            listen: false)
                                        .getUserUid ==
                                    documentSnapshot.data()['useruid']
                                ? Container(
                                    width: 0.0,
                                    height: 0.0,
                                  )
                                : Container(
                                    height: 20,
                                    child: MaterialButton(
                                      color: Colors.grey,
                                      child: Text(
                                        'Follow',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                          );
                        }).toList());
                      }
                    },
                  ),
                )
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
          );
        });
  }
}
