import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/constants/constant_color.dart';

class LandingHelpers with ChangeNotifier {
  final ConstantColors constantColors = ConstantColors();

  // Widget bodyText(BuildContext context) {
  //   return Container(
  //     margin: EdgeInsets.only(top: 150),
  //     alignment: Alignment.topCenter,
  //     child: RichText(
  //       text: TextSpan(
  //           text: "Social",
  //           style: TextStyle(
  //               fontFamily: 'Poppins',
  //               color: Colors.grey.shade900,
  //               fontWeight: FontWeight.bold,
  //               fontSize: 30),
  //           children: <TextSpan>[
  //             TextSpan(
  //                 text: "Media",
  //                 style: TextStyle(
  //                     fontFamily: 'Poppins',
  //                     color: constantColors.blueColor,
  //                     fontWeight: FontWeight.bold,
  //                     fontSize: 30))
  //           ]),
  //     ),
  //   );
  // }

  // Widget mainButton(BuildContext context) {
  //   return Positioned(
  //     top: 450,
  //     child: Container(
  //       width: MediaQuery.of(context).size.width,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           GestureDetector(
  //             child: Container(
  //               child: Icon(
  //                 EvaIcons.emailOutline,
  //                 color: Colors.yellow[300],
  //               ),
  //               width: 80,
  //               height: 40,
  //               decoration: BoxDecoration(
  //                   border: Border.all(color: Colors.yellow[300]),
  //                   borderRadius: BorderRadius.circular(10)),
  //             ),
  //           ),
  //           GestureDetector(
  //             child: Container(
  //               child: Icon(
  //                 EvaIcons.google,
  //                 color: Colors.red,
  //               ),
  //               width: 80,
  //               height: 40,
  //               decoration: BoxDecoration(
  //                   border: Border.all(color: Colors.red),
  //                   borderRadius: BorderRadius.circular(10)),
  //             ),
  //           ),
  //           GestureDetector(
  //             child: Container(
  //               child: Icon(
  //                 EvaIcons.facebook,
  //                 color: Colors.blue,
  //               ),
  //               width: 80,
  //               height: 40,
  //               decoration: BoxDecoration(
  //                   border: Border.all(color: Colors.blue),
  //                   borderRadius: BorderRadius.circular(10)),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget privacyText(BuildContext context) {
  //   return Positioned(
  //     top: 650,
  //     left: 20,
  //     right: 20,
  //     child: Container(
  //       child: Column(
  //         children: [
  //           Text(
  //             "By continuing you agree SocialMedia's Terms of ",
  //             style: TextStyle(color: Colors.grey[600]),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget body(BuildContext context) {
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  "Welcome",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "By continuing you agree KMedia's Terms ",
                  style: TextStyle(color: Colors.grey[600]),
                )
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                "assets/images/logosocial.png",
              ))),
            ),
            Column(children: <Widget>[
              MaterialButton(
                minWidth: double.infinity,
                height: 40,
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.yellow[900]),
                    borderRadius: BorderRadius.circular(50)),
                child: ListTile(
                  leading: Icon(
                    EvaIcons.emailOutline,
                    color: Colors.yellow[900],
                  ),
                  title: Text(
                    "Sign Up With Email ",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                minWidth: double.infinity,
                height: 40,
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(50)),
                child: ListTile(
                  leading: Icon(
                    EvaIcons.google,
                    color: Colors.red,
                  ),
                  title: Text(
                    "Sign Up With Google",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
              )
            ]),
            MaterialButton(
              minWidth: double.infinity,
              height: 40,
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blue[900]),
                  borderRadius: BorderRadius.circular(50)),
              child: ListTile(
                leading: Icon(
                  EvaIcons.facebook,
                  color: Colors.blue[900],
                ),
                title: Text(
                  "Sign Up With Facebook",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
            )
          ],
        ));
  }
}
