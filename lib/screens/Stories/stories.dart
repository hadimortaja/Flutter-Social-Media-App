import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/constants/constant_color.dart';

class Stories extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  Stories({ @required this.documentSnapshot});

  @override
  _StoriesState createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaWidth(context), 
            child: Column(children: [
              Container(
                height: MediaQuery.of(context).size.height,
            width: MediaWidth(context),
            child: Image.network(widget.documentSnapshot.data()['image'],fit: BoxFit.contain,),
              )
            ],),
          ),
        ),
        Positioned(
          top: 30,
          child: Container(
            
          )
        )
      ],),
    );
  }
}
