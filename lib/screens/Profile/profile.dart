import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/screens/Landing/landing_page.dart';
import 'package:social_media_app/screens/Profile/profilehelpers.dart';
import 'package:social_media_app/services/authentication.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[300],
        automaticallyImplyLeading: false,
        title: Image.asset(
          "assets/images/logosocial.png",
          scale: 5,
        ),
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: null,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.grey,
            ),
            onPressed: () {
              Provider.of<ProfileHelpers>(context, listen: false)
                  .logoutDialog(context);
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child:StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(Provider.of<Authentication>(context, listen: false)
                      .getUserUid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Column(
                    children: [
                      Provider.of<ProfileHelpers>(context, listen: false)
                          .headerProfile(context, snapshot),
                      Provider.of<ProfileHelpers>(context, listen: false)
                          .divider(),
                      // Provider.of<ProfileHelpers>(context, listen: false)
                      //     .middleProfile(context, snapshot)
                      Provider.of<ProfileHelpers>(context, listen: false)
                          .footerProfile(context, snapshot),
                    ],
                  );
                }
              },
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
          ),
        ),
      ),
    );
  }
}
