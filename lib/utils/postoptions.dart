import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/services/authentication.dart';
import 'package:social_media_app/services/firebase_operations.dart';

class PostFunctions with ChangeNotifier {
  TextEditingController commentController = TextEditingController();
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
          return Container(
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
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('posts')
                        .doc(docId)
                        .collection('comments')
                        .orderBy('time', descending: true)
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
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.11,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey,
                                        backgroundImage: NetworkImage(
                                            documentSnapshot
                                                .data()['userimage']),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Container(
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
                                          IconButton(
                                            icon: Icon(
                                              Icons.delete,
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
                                            Icons.arrow_forward_ios_outlined),
                                        onPressed: () {},
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Text(
                                            documentSnapshot.data()['comment']),
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
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Container(
                          width: 300,
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
                                commentController.text);
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
          );
        });
  }
}
