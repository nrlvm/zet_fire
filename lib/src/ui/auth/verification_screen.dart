import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zet_fire/src/colors/app_color.dart';
import 'package:zet_fire/src/fire_auth/auth_user_repository.dart';
import 'package:zet_fire/src/ui/main/home/home_screen.dart';
import 'package:zet_fire/src/ui/main/main_screen.dart';
import 'package:zet_fire/src/utils/utils.dart';

class VerificationScreen extends StatefulWidget {
  final String username;
  final String phoneNumber;
  final String password;

  const VerificationScreen({
    Key? key,
    required this.username,
    required this.phoneNumber,
    required this.password,
  }) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final pinPutController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      backgroundColor: AppColor.appbar,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.appbar,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: SvgPicture.asset(
            'assets/icons/arrow_left.svg',
            fit: BoxFit.none,
          ),
        ),
        title: Text(
          'Code Verification',
          style: TextStyle(
            fontFamily: AppColor.fontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 18 * h,
            height: 24.55 / 18,
            color: AppColor.dark,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50 * h,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 25 * h),
            child: Text(
              'Enter the 6 digits code that you received on your '
              'phone number to continue.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppColor.fontFamily,
                fontWeight: FontWeight.w400,
                fontSize: 16 * h,
                height: 26 / 16,
              ),
            ),
          ),
          SizedBox(
            height: 52 * h,
          ),
          Pinput(
            length: 6,
            controller: pinPutController,
            showCursor: false,
            defaultPinTheme: PinTheme(
              width: 40 * w,
              height: 48 * h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColor.grey.withOpacity(0.6),
                  width: 1,
                ),
              ),
              textStyle: TextStyle(
                fontFamily: AppColor.fontFamily,
                fontWeight: FontWeight.w700,
                fontSize: 24 * h,
              ),
            ),
            separator: SizedBox(
              width: 14 * w,
            ),
            focusedPinTheme: PinTheme(
              width: 42 * w,
              height: 50 * h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColor.blue.withOpacity(0.8),
                  width: 1,
                ),
              ),
              textStyle: TextStyle(
                fontFamily: AppColor.fontFamily,
                fontWeight: FontWeight.w700,
                fontSize: 24 * h,
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () async {
              if (loading == false && pinPutController.text.length == 6) {
                loading = true;
                setState(() {});
                await authUserRepository.verificationCode(
                    verificationCode: pinPutController.text);
                String k = await authUserRepository.verificationCode(
                  verificationCode: pinPutController.text,
                );
                loading = false;
                setState(() {});
                if (k == "") {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('username', widget.username);
                  prefs.setString('password', widget.password);
                  prefs.setString('phone', widget.phoneNumber);
                  Navigator.pushAndRemoveUntil(
                      this.context,
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(),
                      ),
                      (route) => false);
                }
              }
            },
            child: Container(
              height: 56 * h,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(
                horizontal: 16 * w,
                vertical: Platform.isIOS ? 24 * h : 16 * h,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColor.blue.withOpacity(0.9),
              ),
              child: loading
                  ? CircularProgressIndicator(
                      color: AppColor.white,
                    )
                  : Center(
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontFamily: AppColor.fontFamily,
                          fontWeight: FontWeight.w600,
                          fontSize: 20 * h,
                          letterSpacing: 1.5,
                          color: AppColor.white,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
