import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/screens/Homepage/homepage.dart';
import 'package:social_media_app/services/authentication.dart';
import 'package:social_media_app/services/firebase_operations.dart';

class AltProfileHelpers with ChangeNotifier {
  Widget appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_rounded),
        color: Colors.grey,
        onPressed: () {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: HomePage(), type: PageTransitionType.bottomToTop));
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.more_vert),
          color: Colors.grey,
          onPressed: () {
            // Navigator.pushReplacement(
            //     context,
            //     PageTransition(
            //         child: HomePage(), type: PageTransitionType.bottomToTop));
          },
        ),
      ],
      title: Image.asset(
        "assets/images/logosocial.png",
        scale: 5,
      ),
    );
  }

  Widget headerProfile(BuildContext context,
      AsyncSnapshot<DocumentSnapshot> snapshot, String userUid) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                backgroundImage: (snapshot.data.data()['userimage'] == null)
                    ? NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png")
                    : NetworkImage(snapshot.data.data()['userimage']),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        createColumns("Posts", "0"),
                        //createColumns("Followers", "0"),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(snapshot.data.data()['useruid'])
                                  .collection('followers')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return Text(
                                      snapshot.data.docs.length.toString());
                                }
                              },
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                "Followers",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),

                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(snapshot.data.data()['useruid'])
                                  .collection('following')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  return Text(
                                      snapshot.data.docs.length.toString());
                                }
                              },
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                "Following",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              snapshot.data.data()['username'],
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              snapshot.data.data()['useremail'],
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w300),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.10,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    Provider.of<FirebaseOperations>(context, listen: false)
                        .followUser(
                            userUid,
                            Provider.of<Authentication>(context, listen: false)
                                .getUserUid,
                            {
                              'username': Provider.of<FirebaseOperations>(
                                      context,
                                      listen: false)
                                  .getinitUserName,
                              'userimage': Provider.of<FirebaseOperations>(
                                      context,
                                      listen: false)
                                  .getinitUserImage,
                              'useruid': Provider.of<Authentication>(context,
                                      listen: false)
                                  .getUserUid,
                              'useremail': Provider.of<FirebaseOperations>(
                                      context,
                                      listen: false)
                                  .getinitUserEmail,
                              'time': Timestamp.now(),
                            },
                            Provider.of<Authentication>(context, listen: false)
                                .getUserUid,
                            userUid,
                            {
                              'username': snapshot.data.data()['username'],
                              'userimage': snapshot.data.data()['userimage'],
                              'useremail': snapshot.data.data()['useremail'],
                              'useruid': snapshot.data.data()['useruid'],
                              'time': Timestamp.now(),
                            })
                        .whenComplete(() {
                      followedNotification(
                          context, snapshot.data.data()['username']);
                    });
                  },
                  child: Text(
                    "Follow",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                MaterialButton(
                  color: Colors.blue,
                  onPressed: () {},
                  child: Text(
                    "Message",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget divider() {
    return Center(
      child: Container(
        height: 25,
        width: 350,
        child: Divider(
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget footerProfile(BuildContext context, dynamic snapshot) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        child: Image.asset("assets/images/empty.png"),
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }

  createColumns(String title, String count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          child: Text(
            title,
            style: TextStyle(
                fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }

  followedNotification(BuildContext context, String name) {
    return Scaffold.of(context)
        .showSnackBar(SnackBar(content: new Text("Followed $name")));
  }
}
