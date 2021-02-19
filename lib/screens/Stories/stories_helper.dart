import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/screens/Stories/stories_widgets.dart';

class StoriesHelper extends ChangeNotifier {
  UploadTask imageUploadTask;

  final picker = ImagePicker();

  File storyImage;

  File get getStoryImage => storyImage;
  final StoryWidgets storyWidgets = StoryWidgets();

  String storyImageUrl;
  String get getStoryImageUrl => storyImageUrl;

  Future selectStoryImage(BuildContext context, ImageSource source) async {
    final pickedStoryImage = await picker.getImage(source: source);
    pickedStoryImage == null
        ? print("Error")
        : storyImage = File(pickedStoryImage.path);
    storyImage != null
        ? storyWidgets.previewStoryImage(context, storyImage)
        : print('error');
    notifyListeners();
  }

  Future uploadStoryImage(BuildContext context) async {
    Reference imageReference = FirebaseStorage.instance
        .ref()
        .child('stories/${getStoryImage.path}/${Timestamp.now()}');
    imageUploadTask = imageReference.putFile(getStoryImage);
    await imageUploadTask.whenComplete(() {
      print("Story Image Uploaded");
    });
    imageReference.getDownloadURL().then((url) {
      storyImageUrl = url;
      print(storyImageUrl);
    });
    notifyListeners();
  }
}
