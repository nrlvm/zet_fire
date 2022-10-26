import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zet_fire/src/bloc/auth_bloc.dart';
import 'package:zet_fire/src/colors/app_color.dart';
import 'package:zet_fire/src/fire_auth/auth_user_repository.dart';
import 'package:zet_fire/src/model/user_model.dart';
import 'package:zet_fire/src/ui/auth/main_auth_screen.dart';
import 'package:zet_fire/src/utils/utils.dart';
import 'package:zet_fire/src/widget/app/custom_network_image.dart';
import 'package:zet_fire/src/widget/center_dialog/bottom_widget.dart';

class SettingsScreen extends StatefulWidget {
  final UserModel data;

  const SettingsScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final nameController = TextEditingController();
  final userNameController = TextEditingController();
  final cityController = TextEditingController();
  UserModel model = UserModel.fromJson({});

  @override
  void initState() {
    nameController.text = widget.data.name;
    userNameController.text = widget.data.userName;
    cityController.text = widget.data.city;
    model = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.appbar,
          elevation: 1,
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.transparent,
              child: SvgPicture.asset(
                'assets/icons/arrow_left.svg',
                fit: BoxFit.none,
              ),
            ),
          ),
          title: Text(
            'Your Profile',
            style: TextStyle(
              fontFamily: AppColor.fontFamily,
              fontWeight: FontWeight.w700,
              fontSize: 28 * h,
              color: AppColor.dark,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text(
                      'Are you sure that\nyou want to sign out?',
                    ),
                    actions: [
                      CupertinoDialogAction(
                        child: Text(
                          'yes',
                          style: TextStyle(color: AppColor.red),
                        ),
                        onPressed: () async {
                          authUserRepository.signOut();
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.clear();
                          Navigator.pushAndRemoveUntil(
                              this.context,
                              MaterialPageRoute(
                                builder: (context) => const MainAuthScreen(),
                              ),
                              (route) => false);
                        },
                      ),
                      CupertinoDialogAction(
                        child: const Text('no'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                alignment: AlignmentDirectional.center,
                color: Colors.transparent,
                child: Text(
                  'Sign Out',
                  style: TextStyle(
                    fontFamily: AppColor.fontFamily,
                    fontWeight: FontWeight.w700,
                    fontSize: 16 * h,
                    color: AppColor.red,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 16 * h,
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25 * w),
          child: ListView(
            children: [
              SizedBox(
                height: 24 * h,
              ),
              Center(
                child: Container(
                  height: 96 * h,
                  width: 96 * h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(86),
                    border: Border.all(
                      color: AppColor.dark.withOpacity(0.5),
                    ),
                  ),
                  child: model.userPhoto == ''
                      ? Center(
                          child: SvgPicture.asset(
                            'assets/icons/user.svg',
                            height: 48 * h,
                            width: 48 * h,
                            // fit: BoxFit.scaleDown,
                            color: AppColor.dark.withOpacity(0.2),
                          ),
                        )
                      : CustomNetworkImage(
                          borderRadius: BorderRadius.circular(90),
                          height: 96 * h,
                          width: 96 * h,
                          image: model.userPhoto,
                          boxFit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(
                height: 24 * h,
              ),
              Text(
                'Name and Surname',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: AppColor.fontFamily,
                  fontWeight: FontWeight.w500,
                  fontSize: 16 * h,
                  color: AppColor.dark,
                ),
              ),
              SizedBox(
                height: 8 * h,
              ),
              Container(
                height: 56 * h,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 16 * w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColor.dark.withOpacity(0.5),
                  ),
                ),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.center,
                  controller: nameController,
                  style: TextStyle(
                    fontFamily: AppColor.fontFamily,
                    fontWeight: FontWeight.w700,
                    fontSize: 16 * h,
                    color: AppColor.dark,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Write down your name and surname',
                    hintStyle: TextStyle(
                      fontFamily: AppColor.fontFamily,
                      fontWeight: FontWeight.w400,
                      fontSize: 16 * h,
                      color: AppColor.dark.withOpacity(0.4),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 24 * h,
              ),
              Text(
                'Username',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: AppColor.fontFamily,
                  fontWeight: FontWeight.w500,
                  fontSize: 16 * h,
                  color: AppColor.dark,
                ),
              ),
              SizedBox(
                height: 8 * h,
              ),
              Container(
                height: 56 * h,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 16 * w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColor.dark.withOpacity(0.5),
                  ),
                ),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.center,
                  controller: userNameController,
                  style: TextStyle(
                    fontFamily: AppColor.fontFamily,
                    fontWeight: FontWeight.w700,
                    fontSize: 16 * h,
                    color: AppColor.dark,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Your username',
                    hintStyle: TextStyle(
                      fontFamily: AppColor.fontFamily,
                      fontWeight: FontWeight.w400,
                      fontSize: 16 * h,
                      color: AppColor.dark.withOpacity(0.4),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 24 * h,
              ),
              Text(
                'City',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: AppColor.fontFamily,
                  fontWeight: FontWeight.w500,
                  fontSize: 16 * h,
                  color: AppColor.dark,
                ),
              ),
              SizedBox(
                height: 8 * h,
              ),
              Container(
                height: 56 * h,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 16 * w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColor.dark.withOpacity(0.5),
                  ),
                ),
                child: TextField(
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.center,
                  controller: cityController,
                  style: TextStyle(
                    fontFamily: AppColor.fontFamily,
                    fontWeight: FontWeight.w700,
                    fontSize: 16 * h,
                    color: AppColor.dark,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'City',
                    hintStyle: TextStyle(
                      fontFamily: AppColor.fontFamily,
                      fontWeight: FontWeight.w400,
                      fontSize: 16 * h,
                      color: AppColor.dark.withOpacity(0.4),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 46 * h,
              ),
              GestureDetector(
                onTap: () {
                  if (userNameController.text.isNotEmpty) {
                    model.name = nameController.text;
                    model.userName = userNameController.text;
                    model.city = cityController.text;
                    authBloc.updateUser(model);
                    Navigator.pop(context);
                  } else {
                    BottomWidget.modalBottom(
                      'Save Failed',
                      'Set up at least username',
                      h,
                      w,
                      context,
                    );
                  }
                },
                child: Container(
                  height: 56 * h,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(
                    bottom: Platform.isIOS ? 24 * h : 16 * h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColor.blue,
                  ),
                  child: Center(
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontFamily: AppColor.fontFamily,
                        fontWeight: FontWeight.w600,
                        fontSize: 24 * h,
                        color: AppColor.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 350 * h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
