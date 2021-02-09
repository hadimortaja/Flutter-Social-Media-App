import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/screens/Messaging/groupmessage.dart';
import 'package:social_media_app/services/authentication.dart';
import 'package:social_media_app/services/firebase_operations.dart';

class ChatRoomHelpers with ChangeNotifier {
  String chatroomAvatarUrl, chatroomId;
  String get getChatroomId => chatroomId;
  String get getChatroomAvatarUrl => chatroomAvatarUrl;
  final TextEditingController chatroomNameController = TextEditingController();
  showCreateChatroomSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150),
                    child: Divider(
                      color: Colors.black,
                      thickness: 4.0,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Select Chatroom Avatar",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('chatroomIcons')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return ListView(
                              scrollDirection: Axis.horizontal,
                              children: snapshot.data.docs
                                  .map((DocumentSnapshot documentSnapshot) {
                                return GestureDetector(
                                  onTap: () {
                                    //print(documentSnapshot.data()['image']);
                                    chatroomAvatarUrl =
                                        documentSnapshot.data()['image'];
                                    print(chatroomAvatarUrl);
                                    notifyListeners();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: chatroomAvatarUrl ==
                                                      documentSnapshot
                                                          .data()['image']
                                                  ? Colors.blue
                                                  : Colors.transparent)),
                                      height: 10,
                                      width: 40,
                                      child: Image.network(
                                          documentSnapshot.data()['image']),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          }
                        },
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextField(
                          textCapitalization: TextCapitalization.words,
                          controller: chatroomNameController,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          decoration: InputDecoration(
                            hintText: "Enter Chatroom Id",
                          ),
                        ),
                      ),
                      FloatingActionButton(
                        backgroundColor: Colors.blueGrey,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          Provider.of<FirebaseOperations>(context,
                                  listen: false)
                              .submitChatroomData(chatroomNameController.text, {
                            'roomavatar': getChatroomAvatarUrl,
                            'time': Timestamp.now(),
                            'roomname': chatroomNameController.text,
                            'username': Provider.of<FirebaseOperations>(context,
                                    listen: false)
                                .getinitUserName,
                            'userimage': Provider.of<FirebaseOperations>(
                                    context,
                                    listen: false)
                                .getinitUserImage,
                            'useremail': Provider.of<FirebaseOperations>(
                                    context,
                                    listen: false)
                                .getinitUserEmail,
                            'useruid': Provider.of<Authentication>(context,
                                    listen: false)
                                .getUserUid,
                          }).whenComplete(() {
                            chatroomNameController.clear();
                            Navigator.pop(context);
                          });
                        },
                      )
                    ],
                  )
                ],
              ),
              height: MediaQuery.of(context).size.height * 0.27,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(12)),
            ),
          );
        });
  }

  showChatroomDetails(BuildContext context, DocumentSnapshot documentSnapshot) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.27,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
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
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Members",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )),
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Admin",
                        style: TextStyle(color: Colors.grey),
                      ),
                    )),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage:
                            NetworkImage(documentSnapshot.data()['userimage']),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(documentSnapshot.data()['username']),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  showChatrooms(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('chatrooms').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView(
            children:
                snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
              return ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: GroupMessage(
                            documentSnapshot: documentSnapshot,
                          ),
                          type: PageTransitionType.leftToRight));
                },
                onLongPress: () {
                  showChatroomDetails(context, documentSnapshot);
                },
                title: Text(documentSnapshot.data()['roomname']),
                subtitle: Text("Last Message"),
                trailing: Text("2 hours ago"),
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage:
                      NetworkImage(documentSnapshot.data()['roomavatar']),
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }
}
