import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/constants/constant_color.dart';
import 'package:social_media_app/screens/Homepage/homepage.dart';
import 'package:social_media_app/screens/Landing/landing_services.dart';
import 'package:social_media_app/screens/Landing/landing_utils.dart';
import 'package:social_media_app/services/authentication.dart';

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
                  emailAuthSheet(context);
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
                    "Continue with Email",
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
                  print("Siging with Google");
                  Provider.of<Authentication>(context, listen: false)
                      .signInWithGoogle()
                      .whenComplete(() {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            child: HomePage(),
                            type: PageTransitionType.rightToLeft));
                  });
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
                    "Sign in With Google",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
              )
            ]),
            // MaterialButton(
            //   minWidth: double.infinity,
            //   height: 40,
            //   onPressed: () {
            //     // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            //   },
            //   shape: RoundedRectangleBorder(
            //       side: BorderSide(color: Colors.blue[900]),
            //       borderRadius: BorderRadius.circular(50)),
            //   child: ListTile(
            //     leading: Icon(
            //       EvaIcons.facebook,
            //       color: Colors.blue[900],
            //     ),
            //     title: Text(
            //       "Sign in With Facebook",
            //       style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            //     ),
            //   ),
            // )
          ],
        ));
  }

  emailAuthSheet(BuildContext context) {
    return showModalBottomSheet(
        isDismissible: true,
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150),
                  child: Divider(
                    thickness: 4.0,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Users Already Signed Up :",
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
                Provider.of<LandingService>(context, listen: false)
                    .passwordLessSignIn(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 150,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.yellow[900]),
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          'SIGNIN',
                          style: TextStyle(
                            color: Colors.yellow[900],
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () {
                          //  Navigator.pop(context);//////////
                          Provider.of<LandingService>(context, listen: false)
                              .signInSheet(context);
                        },
                      ),
                    ),
                    Container(
                      width: 150,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.blue[900]),
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          'SignUp ',
                          style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () {
                          //  Navigator.pop(context);/////////////

                          Provider.of<LandingUtils>(context, listen: false)
                              .selectAvatarOptionsSheet(context);
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                )),
          );
        });
  }
}
