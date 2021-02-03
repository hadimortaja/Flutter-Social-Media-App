import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/utils/uploadpost.dart';

class FeedHelpers with ChangeNotifier {
  Widget appBar(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.grey),
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
          onPressed: () {
            Provider.of<UploadPost>(context, listen: false)
                .selectPostImageType(context);
          },
        )
      ],
    );
  }

  Widget feedBody(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18), topRight: Radius.circular(18))),
        ),
      ),
    );
  }
}
