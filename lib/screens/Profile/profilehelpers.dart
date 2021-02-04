import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/screens/Landing/landing_page.dart';
import 'package:social_media_app/services/authentication.dart';

class ProfileHelpers with ChangeNotifier {
  Widget headerProfile(BuildContext context, dynamic snapshot) {
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
    // return Container(
    //   height: MediaQuery.of(context).size.height * 0.2,
    //   width: MediaQuery.of(context).size.width,
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     children: [
    //       Container(
    //           height: 200,
    //           width: 180,
    //           child: Column(
    //             children: [
    //               GestureDetector(
    //                 onTap: () {},
    //                 child: CircleAvatar(
    //                   backgroundColor: Colors.grey,
    //                   radius: 40,
    //                   backgroundImage:
    //                       NetworkImage(snapshot.data.data()['userimage']), //
    //                 ),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 8.0),
    //                 child: Text(
    //                   snapshot.data.data()['username'],
    //                   style: TextStyle(fontSize: 16, color: Colors.black),
    //                 ),
    //               ),
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 8.0),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Icon(Icons.email),
    //                     Text(
    //                       snapshot.data.data()['useremail'],
    //                       style: TextStyle(fontSize: 16, color: Colors.black),
    //                     ),
    //                   ],
    //                 ),
    //               )
    //             ],
    //           )),
    //       Container(
    //         child: Column(
    //           children: [
    //             Row(
    //               children: [
    //                 Container(
    //                   decoration: BoxDecoration(
    //                       color: Colors.grey,
    //                       borderRadius: BorderRadius.circular(15)),
    //                   height: 70,
    //                   width: 80,
    //                   child: Column(
    //                     children: [
    //                       Text(
    //                         "0",
    //                         style: TextStyle(fontSize: 16, color: Colors.black),
    //                       ),
    //                       Text(
    //                         "Followers",
    //                         style: TextStyle(fontSize: 16, color: Colors.black),
    //                       )
    //                     ],
    //                   ),
    //                 ),
    //                 Container(
    //                   decoration: BoxDecoration(
    //                       color: Colors.grey,
    //                       borderRadius: BorderRadius.circular(15)),
    //                   height: 70,
    //                   width: 80,
    //                   child: Column(
    //                     children: [
    //                       Text(
    //                         "0",
    //                         style: TextStyle(fontSize: 16, color: Colors.black),
    //                       ),
    //                       Text(
    //                         "Following",
    //                         style: TextStyle(fontSize: 16, color: Colors.black),
    //                       )
    //                     ],
    //                   ),
    //                 )
    //               ],
    //             ),
    //             Container(
    //               decoration: BoxDecoration(
    //                   color: Colors.grey,
    //                   borderRadius: BorderRadius.circular(15)),
    //               height: 70,
    //               width: 80,
    //               child: Column(
    //                 children: [
    //                   Text(
    //                     "0",
    //                     style: TextStyle(fontSize: 16, color: Colors.black),
    //                   ),
    //                   Text(
    //                     "Posts",
    //                     style: TextStyle(fontSize: 16, color: Colors.black),
    //                   )
    //                 ],
    //               ),
    //             )
    //           ],
    //         ),
    //       )
    //     ],
    //   ),
    // );
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

  // Widget middleProfile(BuildContext context, dynamic snapshot) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.start,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.only(top: 10),
  //         child: Container(
  //           width: 150,
  //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.0)),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: [
  //               Icon(
  //                 FontAwesomeIcons.userAstronaut,
  //               ),
  //               Text("Recently Added")
  //             ],
  //           ),
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.only(top: 20),
  //         child: Container(
  //           height: MediaQuery.of(context).size.height * 0.1,
  //           width: MediaQuery.of(context).size.width,
  //           decoration: BoxDecoration(
  //               color: Colors.grey.shade400,
  //               borderRadius: BorderRadius.circular(15)),
  //         ),
  //       )
  //     ],
  //   );
  // }
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

  logoutDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Log out ?"),
            content: Text('We hate to see you leave...'),
            actions: [
              FlatButton(
                onPressed: () {
                  print("you choose no");
                  Navigator.of(context).pop(false);
                },
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () {
                  Provider.of<Authentication>(context, listen: false)
                      .logOutViaEmail()
                      .whenComplete(() {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: LandingPage(),
                            type: PageTransitionType.bottomToTop));
                  });
                },
                child: Text('Yes'),
              ),
            ],
          );
        });
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
