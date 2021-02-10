import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GroupMessage extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  GroupMessage({@required this.documentSnapshot});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        centerTitle: true,
        title: Text(documentSnapshot.data()['roomname']),
      ),
    );
  }
}
