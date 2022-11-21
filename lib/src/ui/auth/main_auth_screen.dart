import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zet_fire/src/auth/auth_repo.dart';
import 'package:zet_fire/src/bloc/auth_bloc.dart';
import 'package:zet_fire/src/colors/app_color.dart';
import 'package:zet_fire/src/model/user_model.dart';
import 'package:zet_fire/src/ui/auth/login_page.dart';
import 'package:zet_fire/src/ui/auth/sign_up_page.dart';
import 'package:zet_fire/src/ui/main/main_screen.dart';
import 'package:zet_fire/src/utils/utils.dart';
import 'package:zet_fire/src/widget/center_dialog/bottom_widget.dart';

class MainAuthScreen extends StatefulWidget {
  const MainAuthScreen({Key? key}) : super(key: key);

  @override
  State<MainAuthScreen> createState() => _MainAuthScreenState();
}

class _MainAuthScreenState extends State<MainAuthScreen> {
  final controller = PageController();
  bool k = true;

  String googleEmail = '';
  String phoneLog = '';
  String passwordLog = '';

  String usernameSign = '';
  String phoneSign = '';
  String passwordSign = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 68 * h,
          ),
          Center(
            child: SvgPicture.asset(
              'assets/icons/logo.svg',
              height: 64 * h,
              fit: BoxFit.fitHeight,
            ),
          ),
          SizedBox(
            height: 20 * h,
          ),
          Container(
            height: 73 * h,
            padding: EdgeInsets.symmetric(horizontal: 28 * h),
            child: k == true
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Log In',
                            style: TextStyle(
                              fontFamily: AppColor.fontFamily,
                              fontWeight: FontWeight.w700,
                              fontSize: 20 * h,
                              height: 33 / 20,
                              color: AppColor.dark,
                            ),
                          ),
                          SizedBox(
                            height: 4 * h,
                          ),
                          Container(
                            height: 6 * h,
                            width: 6 * h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6 * h),
                              color: AppColor.blue,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 46 * w,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.nextPage(
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.easeInOut);
                          setState(() {
                            k = false;
                          });
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontFamily: AppColor.fontFamily,
                            fontWeight: FontWeight.w600,
                            fontSize: 20 * h,
                            height: 27.28 / 20,
                            color: AppColor.grey,
                          ),
                        ),
                      ),
                      const Spacer(
                        flex: 2,
                      )
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.previousPage(
                            duration: const Duration(milliseconds: 350),
                            curve: Curves.easeInOut,
                          );
                          setState(() {
                            k = true;
                          });
                        },
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            fontFamily: AppColor.fontFamily,
                            fontWeight: FontWeight.w600,
                            fontSize: 20 * h,
                            height: 27.28 / 20,
                            color: AppColor.grey,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 46 * w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Sign Up',
                            style: TextStyle(
                              fontFamily: AppColor.fontFamily,
                              fontWeight: FontWeight.w700,
                              fontSize: 20 * h,
                              height: 33 / 20,
                              color: AppColor.dark,
                            ),
                          ),
                          SizedBox(
                            height: 4 * h,
                          ),
                          Container(
                            height: 6 * h,
                            width: 6 * h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6 * h),
                              color: AppColor.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
          Expanded(
            child: PageView(
              controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                LoginPage(
                  phone: (String phone) {
                    phoneLog = phone;
                  },
                  password: (String password) {
                    passwordLog = password;
                  },
                  signGoogle: () async {
                    print(googleEmail);
                    googleEmail = await authRepo.handleSignIn();

                  },
                ),
                SignUpPage(
                  username: (String username) {
                    usernameSign = username;
                  },
                  phone: (String phone) {
                    phoneSign = phone;
                  },
                  password: (String password) {
                    passwordSign = password;
                  },
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              if (!loading) {
                if (controller.page == 0) {
                  if (passwordLog.isNotEmpty && phoneLog.isNotEmpty) {
                    loading = true;
                    setState(() {});
                    bool k = await authBloc.logIn(phoneLog, passwordLog);
                    if (k == true) {
                      Navigator.pushAndRemoveUntil(
                          this.context,
                          MaterialPageRoute(
                            builder: (context) => const MainScreen(),
                          ),
                          (route) => false);
                    } else {
                      BottomWidget.modalBottom(
                        'Login failed',
                        'Either phone number or password wrong',
                        h,
                        w,
                        this.context,
                      );
                    }
                    setState(() {
                      loading = false;
                    });
                  } else if (phoneLog.isEmpty || passwordLog.isEmpty) {
                    BottomWidget.modalBottom(
                      'Login Failed',
                      'Write down phone number and password',
                      h,
                      w,
                      context,
                    );
                  }
                } else if (controller.page == 1) {
                  if (usernameSign.isNotEmpty &&
                      phoneSign.isNotEmpty &&
                      passwordSign.isNotEmpty) {
                    loading = true;
                    setState(() {});
                    bool alreadyUserNumber =
                        await authBloc.numberAlreadyUser(phoneSign);
                    if (alreadyUserNumber == false) {
                      authBloc.saveUser(
                        UserModel(
                          userName: usernameSign,
                          phone: phoneSign,
                          password: passwordSign,
                        ),
                      );
                      Navigator.pushAndRemoveUntil(
                        this.context,
                        MaterialPageRoute(
                          builder: (context) => const MainScreen(),
                        ),
                        (route) => false,
                      );
                    } else {
                      BottomWidget.modalBottom(
                        'User Exists',
                        'User with this phone number is already registered',
                        h,
                        w,
                        this.context,
                      );
                    }
                    loading = false;
                    setState(() {});
                  } else if (usernameSign.isEmpty ||
                      phoneSign.isEmpty ||
                      passwordSign.isEmpty) {
                    BottomWidget.modalBottom(
                      'Sign up failed',
                      'Write down the username, phone number and password',
                      h,
                      w,
                      context,
                    );
                  }
                }
              }
            },
            child: Container(
              height: 56 * h,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(
                horizontal: 25 * w,
                vertical: Platform.isIOS ? 24 * h : 16 * h,
              ),
              decoration: BoxDecoration(
                color: AppColor.blue,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Center(
                child: loading
                    ? CircularProgressIndicator(
                        color: AppColor.white,
                      )
                    : Text(
                        k ? 'Login' : 'Sign up',
                        style: TextStyle(
                          fontFamily: AppColor.fontFamily,
                          fontWeight: FontWeight.w700,
                          fontSize: 18 * h,
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
