import 'package:flutter/material.dart';
import 'package:social_media_app/constants/constant_color.dart';

class LandingHelpers with ChangeNotifier {
  final ConstantColors constantColors = ConstantColors();

  Widget bodyText(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 150),
      alignment: Alignment.topCenter,
      child: RichText(
        text: TextSpan(
            text: "Social",
            style: TextStyle(
                fontFamily: 'Poppins',
                color: constantColors.whiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 30),
            children: <TextSpan>[
              TextSpan(
                  text: "Media",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      color: constantColors.blueColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30))
            ]),
      ),
    );
  }
  
}
