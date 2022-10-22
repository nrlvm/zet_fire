import 'package:flutter/material.dart';
import 'package:zet_fire/src/utils/utils.dart';

import '../../../colors/app_color.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    return Scaffold(
      backgroundColor: AppColor.screen,
      appBar: AppBar(
        backgroundColor: AppColor.appbar,
        elevation: 1,
        centerTitle: false,
        title: Text(
          'Explore',
          style: TextStyle(
              fontFamily: AppColor.fontFamily,
              fontWeight: FontWeight.w700,
              fontSize: 28 * h,
              color: AppColor.dark),
        ),
      ),
    );
  }
}
