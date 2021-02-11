import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/services/authentication.dart';
import 'package:social_media_app/services/firebase_operations.dart';

class GroupMessageHelper with ChangeNotifier{

  sendMessage(BuildContext context,DocumentSnapshot documentSnapshot,TextEditingController messageController){
    return FirebaseFirestore.instance.collection('chatrooms').doc(
      documentSnapshot.id,
      
    ).collection('messages').add({
      'message':messageController.text,
      'time':Timestamp.now(),
      'useruid':Provider.of<Authentication>(context,listen: false).getUserUid,
      'username':Provider.of<FirebaseOperations>(context,listen: false).getinitUserName,
      'userimage':Provider.of<FirebaseOperations>(context,listen: false).getinitUserImage,
    });

  }
  
}