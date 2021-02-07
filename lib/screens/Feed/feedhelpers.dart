import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/screens/AltProfile/alt_profile.dart';
import 'package:social_media_app/services/authentication.dart';
import 'package:social_media_app/utils/postoptions.dart';
import 'package:social_media_app/utils/uploadpost.dart';

class FeedHelpers with ChangeNotifier {
  Widget appBar(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.grey),
      centerTitle: true,
      backgroundColor: Colors.grey[300],
      automaticallyImplyLeading: false,
      title: Image.asset(
        "assets/images/logosocial.png",
        scale: 5,
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.camera_enhance_rounded,
            color: Colors.grey,
          ),
          onPressed: () {
            Provider.of<UploadPost>(context, listen: false)
                .selectPostImageType(context);
          },
        )
      ],
    );
  }

  Widget feedBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .orderBy('time', descending: true)
                .snapshots(), /////
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: Container(
                  height: 10,
                  width: 10,
                  child: CircularProgressIndicator(),
                ));
              } else {
                return loadPosts(context, snapshot);
              }
            },
          ),
          // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18), topRight: Radius.circular(18))),
        ),
      ),
    );
  }

  Widget loadPosts(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    return SingleChildScrollView(
      child: Column(
        children: snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
          Provider.of<PostFunctions>(context, listen: false)
              .showTimeAgo(documentSnapshot.data()['time']);
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ListTile(
                  leading: GestureDetector(
                    onTap: () {
                      if (documentSnapshot.data()['useruid'] !=
                          Provider.of<Authentication>(context, listen: false)
                              .getUserUid) {
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: AltProfile(
                                  userUid: documentSnapshot.data()['useruid'],
                                ),
                                type: PageTransitionType.bottomToTop));
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage:
                          NetworkImage(documentSnapshot.data()['userimage']),
                    ),
                  ),
                  title: Text(documentSnapshot.data()['username']),
                  subtitle: Row(
                    children: [
                      Text("${documentSnapshot.data()['caption']}"),
                      Text(
                        " ,${Provider.of<PostFunctions>(context, listen: false).getImageTimePosted.toString()}",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: GestureDetector(
                    onDoubleTap: () {
                      print("adding like double tap...");
                      Provider.of<PostFunctions>(context, listen: false)
                          .addLike(
                              context,
                              documentSnapshot.data()['caption'],
                              Provider.of<Authentication>(context,
                                      listen: false)
                                  .getUserUid);
                    },
                    child: Container(
                      child: (documentSnapshot.data()['postimage'] == null)
                          ? CircularProgressIndicator()
                          : Image.network(
                              documentSnapshot.data()['postimage'],
                              scale: 2,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onLongPress: () {
                              Provider.of<PostFunctions>(context, listen: false)
                                  .showLikes(context,
                                      documentSnapshot.data()['caption']);
                            },
                            onTap: () {
                              print("adding like...");
                              Provider.of<PostFunctions>(context, listen: false)
                                  .addLike(
                                      context,
                                      documentSnapshot.data()['caption'],
                                      Provider.of<Authentication>(context,
                                              listen: false)
                                          .getUserUid);
                            },
                            child: Icon(
                              FontAwesomeIcons.heart,
                              color: Colors.black,
                            ),
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('posts')
                                .doc(
                                  documentSnapshot.data()['caption'],
                                )
                                .collection('likes')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                      snapshot.data.docs.length.toString()),
                                );
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Provider.of<PostFunctions>(context, listen: false)
                                  .showCommentsSheet(context, documentSnapshot,
                                      documentSnapshot.data()['caption']);
                            },
                            child: Icon(
                              FontAwesomeIcons.comment,
                              color: Colors.black,
                            ),
                          ),
                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('posts')
                                .doc(
                                  documentSnapshot.data()['caption'],
                                )
                                .collection('comments')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                      snapshot.data.docs.length.toString()),
                                );
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Provider.of<Authentication>(context, listen: false)
                                .getUserUid ==
                            documentSnapshot.data()['useruid']
                        ? IconButton(
                            icon: Icon(Icons.more_vert),
                            onPressed: () {
                              Provider.of<PostFunctions>(context, listen: false)
                                  .showPostOptions(context,
                                      documentSnapshot.data()['caption']);
                            },
                          )
                        : Container(
                            width: 0,
                            height: 0,
                          )
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
