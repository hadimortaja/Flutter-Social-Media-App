import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/constants/constant_color.dart';
import 'package:social_media_app/screens/Landing/landing_helper.dart';

class LandingPage extends StatelessWidget {
  final ConstantColors constantColors = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.whiteColor,
      body: Stack(
        children: [
          //bodyColor(),
          //Provider.of<LandingHelpers>(context, listen: false).bodyText(context),
          //Provider.of<LandingHelpers>(context, listen: false)
          // .mainButton(context),
          // Provider.of<LandingHelpers>(context, listen: false)
          //     .privacyText(context),
          Provider.of<LandingHelpers>(context, listen: false).body(context),
        ],
      ),
    );
  }

  // bodyColor() {
  //   return Container(
  //     color: Colors.white,
  //     //decoration: BoxDecoration(

  //     // gradient: LinearGradient(
  //     //     begin: Alignment.topCenter,
  //     //     end: Alignment.bottomCenter,
  //     //     stops: [0.5, 0.9],
  //     // colors: [Colors.grey.shade900, Colors.grey.shade900])),
  //   );
  // }
}
