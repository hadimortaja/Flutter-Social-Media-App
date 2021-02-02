import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/screens/Feed/feedhelpers.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: Provider.of<FeedHelpers>(context,listen: false).appBar(context),
    );
  }
}