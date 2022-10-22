import 'package:flutter/material.dart';
import 'package:zet_fire/src/colors/app_color.dart';

import '../../../utils/utils.dart';

class AllChatsScreen extends StatefulWidget {
  const AllChatsScreen({Key? key}) : super(key: key);

  @override
  State<AllChatsScreen> createState() => _AllChatsScreenState();
}

class _AllChatsScreenState extends State<AllChatsScreen> {
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
          'Chats',
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
