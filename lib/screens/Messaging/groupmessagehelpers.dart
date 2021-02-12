import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/services/authentication.dart';
import 'package:social_media_app/services/firebase_operations.dart';

class GroupMessageHelper with ChangeNotifier {
  showMessages(BuildContext context, DocumentSnapshot documentSnapshot,
      String adminUserUid) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chatrooms')
            .doc(documentSnapshot.id)
            .collection('messages')
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              reverse: true,
              children:
                  snapshot.data.docs.map((DocumentSnapshot documentSnapshot) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.12,
                    child: Stack(
                      children: [
                        Provider.of<Authentication>(context, listen: false)
                                    .getUserUid ==
                                documentSnapshot.data()['useruid']
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 210, top: 10, bottom: 10),
                                child: Container(
                                  width: 170,
                                  constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.8),
                                  child: ListTile(
                                    trailing: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.white,
                                      backgroundImage: NetworkImage(
                                        documentSnapshot.data()['userimage'],
                                      ),
                                    ),

                                    //  NetworkImage(
                                    //   documentSnapshot.data()['userimage'],
                                    title: Container(
                                      child: Text(
                                        documentSnapshot.data()['username'],
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.black),
                                      ),
                                    ),
                                    subtitle: Text(
                                        documentSnapshot.data()['message'],
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12)),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Provider.of<Authentication>(
                                                      context,
                                                      listen: false)
                                                  .getUserUid ==
                                              documentSnapshot.data()['useruid']
                                          ? Colors.blueAccent
                                          : Colors.blueGrey),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, top: 10, bottom: 10),
                                child: Container(
                                  width: 170,
                                  constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.8),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.white,
                                      backgroundImage: NetworkImage(
                                        documentSnapshot.data()['userimage'],
                                      ),
                                    ),

                                    //  NetworkImage(
                                    //   documentSnapshot.data()['userimage'],
                                    title: Container(
                                      child: Text(
                                        documentSnapshot.data()['username'],
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.black),
                                      ),
                                    ),
                                    subtitle: Text(
                                        documentSnapshot.data()['message'],
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12)),
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Provider.of<Authentication>(
                                                      context,
                                                      listen: false)
                                                  .getUserUid ==
                                              documentSnapshot.data()['useruid']
                                          ? Colors.blueAccent
                                          : Colors.blueGrey),
                                ),
                              ),
                        Provider.of<Authentication>(context, listen: false)
                                    .getUserUid ==
                                documentSnapshot.data()['useruid']
                            ? Positioned(
                                left: 370,
                                child: Provider.of<Authentication>(context,
                                                listen: false)
                                            .getUserUid ==
                                        documentSnapshot.data()['useruid']
                                    ? Container(
                                        child: Column(
                                          children: [
                                            IconButton(
                                                icon: Icon(
                                                  Icons.edit,
                                                  size: 16,
                                                ),
                                                onPressed: () {}),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.delete,
                                                  size: 16,
                                                ),
                                                onPressed: () {})
                                          ],
                                        ),
                                      )
                                    : Container(
                                        width: 0.0,
                                        height: 0.0,
                                      ),
                                // Positioned(
                                //     left: 40,
                                //     child: Provider.of<Authentication>(context,
                                //                     listen: false)
                                //                 .getUserUid !=
                                //             documentSnapshot.data()['useruid']
                                //         ? Container(
                                //             height: 0.0,
                                //             width: 0.0,
                                //           )
                                //         : CircleAvatar(
                                //             radius: 15,
                                //             backgroundColor: Colors.white,
                                //             backgroundImage: NetworkImage(
                                //               documentSnapshot.data()['userimage'],
                                //             ),
                                //           ))
                              )
                            : Positioned(
                                top: -2,
                                child: Provider.of<Authentication>(context,
                                                listen: false)
                                            .getUserUid ==
                                        documentSnapshot.data()['useruid']
                                    ? Container(
                                        child: Column(
                                          children: [
                                            IconButton(
                                                icon: Icon(
                                                  Icons.edit,
                                                  size: 16,
                                                ),
                                                onPressed: () {}),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.delete,
                                                  size: 16,
                                                ),
                                                onPressed: () {})
                                          ],
                                        ),
                                      )
                                    : Container(
                                        width: 0.0,
                                        height: 0.0,
                                      ),
                              )
                      ],
                    ));
              }).toList(),
            );
          }
        });
  }

  sendMessage(BuildContext context, DocumentSnapshot documentSnapshot,
      TextEditingController messageController) {
    return FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(
          documentSnapshot.id,
        )
        .collection('messages')
        .add({
      'message': messageController.text,
      'time': Timestamp.now(),
      'useruid': Provider.of<Authentication>(context, listen: false).getUserUid,
      'username': Provider.of<FirebaseOperations>(context, listen: false)
          .getinitUserName,
      'userimage': Provider.of<FirebaseOperations>(context, listen: false)
          .getinitUserImage,
    });
  }
}
