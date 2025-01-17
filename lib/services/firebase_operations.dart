import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/screens/Landing/landing_utils.dart';
import 'package:social_media_app/services/authentication.dart';

class FirebaseOperations with ChangeNotifier {
  UploadTask imageUploadTask;
  String initUserEmail;
  String initUserName;
  String initUserImage;
  String get getinitUserEmail => initUserEmail;
  String get getinitUserName => initUserName;
  String get getinitUserImage => initUserImage;

  Future uploadUserAvatar(BuildContext context) async {
    Reference imageReference = FirebaseStorage.instance.ref().child(
        'userProfileAvatar/${Provider.of<LandingUtils>(context, listen: false).getUserAvatar.path}/${TimeOfDay.now()}');

    imageUploadTask = imageReference.putFile(
        Provider.of<LandingUtils>(context, listen: false).getUserAvatar);
    await imageUploadTask.whenComplete(() {
      print("Image Uploaded");
    });
    imageReference.getDownloadURL().then((url) {
      Provider.of<LandingUtils>(context, listen: false).userAvatarUrl = "$url";
      print(
          "The user profile avatar url => ${Provider.of<LandingUtils>(context, listen: false).userAvatarUrl}");
      notifyListeners();
    });
  }

  Future createUserCollection(BuildContext context, dynamic data) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .set(data);
  }

  Future initUserData(BuildContext context) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .get()
        .then((doc) {
      print("Fetching user data");
      initUserName = doc.data()['username'];
      initUserEmail = doc.data()['useremail'];
      initUserImage = doc.data()['userimage'];
      print(initUserName);
      print(initUserEmail);
      print(initUserImage);

      notifyListeners();
    });
  }

  Future uploadPostData(String postId, dynamic data) async {
    return FirebaseFirestore.instance.collection('posts').doc(postId).set(data);
  }

  Future deleteUserData(String userUid, dynamic collection) async {
    return FirebaseFirestore.instance
        .collection(collection)
        .doc(userUid)
        .delete();
  }

  Future updateCaption(String postId, dynamic data) async {
    return FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .update(data);
  }

  Future followUser(String followingUid, followingDocId, dynamic followingData,
      String followerUid, String followerDocId, dynamic followerData) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(followingUid)
        .collection('followers')
        .doc(followingDocId)
        .set(followingData)
        .whenComplete(() async {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(followerUid)
          .collection('following')
          .doc(followerDocId)
          .set(followerData);
    });
  }

  Future submitChatroomData(String chatRoomName, dynamic chatRoomData) async {
    return FirebaseFirestore.instance
        .collection('chatrooms')
        .doc(chatRoomName)
        .set(chatRoomData);
  }

  // Future <bool> checkFollow(String followingUid, String userid) async {
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(followingUid)
  //       .collection('followers')
  //       .where("useruid", isEqualTo: userid).snapshots();
  // }

  // Future unFollowUser(
  //     String followingUid,
  //     followingDocId,
  //     dynamic followingData,
  //     String followerUid,
  //     String followerDocId,
  //     dynamic followerData) async {
  //   return FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(followingUid)
  //       .collection('followers')
  //       .doc(followingDocId)
  //       .set(followingData)
  //       .whenComplete(() async {
  //     return FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(followerUid)
  //         .collection('following')
  //         .doc(followerDocId)
  //         .set(followerData);
  //   });
  // }
}
