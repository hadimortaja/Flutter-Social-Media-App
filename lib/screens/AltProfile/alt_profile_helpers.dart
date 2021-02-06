import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:social_media_app/screens/Homepage/homepage.dart';

class AltProfileHelpers with ChangeNotifier {
  Widget appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_rounded),
        color: Colors.grey,
        onPressed: () {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: HomePage(), type: PageTransitionType.bottomToTop));
        },
      ),
      
      actions: [
        IconButton(
        icon: Icon(Icons.more_vert),
        color: Colors.grey,
        onPressed: () {
          // Navigator.pushReplacement(
          //     context,
          //     PageTransition(
          //         child: HomePage(), type: PageTransitionType.bottomToTop));
        },
      ),
      ],
      title: Image.asset(
        "assets/images/logosocial.png",
        scale: 5,
      ),
    );
  }
  Widget headerProfile(BuildContext context,AsyncSnapshot<DocumentSnapshot> snapshot,String userUid) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                backgroundImage: (snapshot.data.data()['userimage'] == null)
                    ? NetworkImage(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png")
                    : NetworkImage(snapshot.data.data()['userimage']),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        createColumns("Posts", "0"),
                        createColumns("Followers", "0"),
                        createColumns("Following", "0"),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              snapshot.data.data()['username'],
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              snapshot.data.data()['useremail'],
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    );
   
    
  }
  Widget divider() {
    return Center(
      child: Container(
        height: 25,
        width: 350,
        child: Divider(
          color: Colors.grey,
        ),
      ),
    );
  }
   Widget footerProfile(BuildContext context, dynamic snapshot) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        child: Image.asset("assets/images/empty.png"),
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
      ),
    );
  }
  createColumns(String title, String count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          child: Text(
            title,
            style: TextStyle(
                fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
