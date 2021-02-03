import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/services/authentication.dart';
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
            stream: FirebaseFirestore.instance.collection('posts').snapshots(),
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
              color: Colors.grey[300],
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
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage:
                        NetworkImage(documentSnapshot.data()['userimage']),
                  ),
                  title: Text(documentSnapshot.data()['username']),
                  subtitle: Text(documentSnapshot.data()['caption']),
                ),
              ) ,
              Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: FittedBox(
                  child: (documentSnapshot.data()['postimage'] == null)
                      ? CircularProgressIndicator()
                      : Image.network(
                          documentSnapshot.data()['postimage'],
                          scale: 5,
                          fit: BoxFit.cover,
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
                            child: Icon(
                              FontAwesomeIcons.heart,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text("0"),
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
                            child: Icon(
                              FontAwesomeIcons.comment,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text("0"),
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
                            onPressed: () {},
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
