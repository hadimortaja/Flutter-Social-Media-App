import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/screens/Homepage/homepage.dart';
import 'package:social_media_app/screens/Messaging/groupmessagehelpers.dart';
import 'package:social_media_app/services/authentication.dart';

class GroupMessage extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  TextEditingController messageController = TextEditingController();

  GroupMessage({@required this.documentSnapshot});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Provider.of<Authentication>(context, listen: false).getUserUid ==
                  documentSnapshot.data()['useruid']
              ? IconButton(icon: Icon(Icons.more_vert), onPressed: () {})
              : Container(
                  width: 0,
                  height: 0,
                ),
          IconButton(icon: Icon(Icons.logout), onPressed: () {}),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.grey[300],
        title: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage:
                    NetworkImage(documentSnapshot.data()['roomavatar']),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      documentSnapshot.data()['roomname'],
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                    Text(
                      "2 Members",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              AnimatedContainer(
                child: Provider.of<GroupMessageHelper>(context, listen: false)
                    .showMessages(context, documentSnapshot,
                        documentSnapshot.data()['useruid']),
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
                duration: Duration(seconds: 1),
                curve: Curves.bounceIn,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(hintText: 'Drop a hi..'),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        width: 50,
                        child: RaisedButton(
                          onPressed: () {
                            if (messageController.text.isNotEmpty) {
                              Provider.of<GroupMessageHelper>(context,
                                      listen: false)
                                  .sendMessage(context, documentSnapshot,
                                      messageController);
                              messageController.clear();
                            }
                          },
                          color: Colors.grey,
                          child: Icon(
                            Icons.send,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
