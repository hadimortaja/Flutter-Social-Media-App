import 'package:flutter/material.dart';

class FeedHelpers with ChangeNotifier {
  Widget appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.grey[300],
      automaticallyImplyLeading: false,
      title: Image.asset(
        "assets/images/logosocial.png",
        scale: 5,
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.camera_enhance_rounded,
            color: Colors.grey,
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
