import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/screens/ChatRoom/chatroomhelpers.dart';

class ChatRoom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Provider.of<ChatRoomHelpers>(context, listen: false)
              .showCreateChatroomSheet(context);
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.add,
            color: Colors.black,
          ),
          onPressed: () {
            Provider.of<ChatRoomHelpers>(context, listen: false)
                .showCreateChatroomSheet(context);
          },
        ),
        backgroundColor: Colors.grey[300],
        title: RichText(
          text: TextSpan(
              text: "Chat",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                    text: "Box",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blue))
              ]),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Provider.of<ChatRoomHelpers>(context, listen: false)
            .showChatrooms(context),
      ),
    );
  }
}
