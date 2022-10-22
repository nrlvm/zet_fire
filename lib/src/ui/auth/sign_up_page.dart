import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zet_fire/src/colors/app_color.dart';
import 'package:zet_fire/src/utils/utils.dart';

class SignUpPage extends StatefulWidget {
  final Function(String username) username;
  final Function(String phone) phone;
  final Function(String password) password;

  const SignUpPage({
    Key? key,
    required this.username,
    required this.phone,
    required this.password,
  }) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool k = true;
  final TextEditingController _username = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      backgroundColor: AppColor.appbar,
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 25 * h),
            child: Text(
              'Username',
              style: TextStyle(
                fontFamily: AppColor.fontFamily,
                fontWeight: FontWeight.w600,
                fontSize: 16 * h,
                height: 27 / 16,
                color: AppColor.dark,
              ),
            ),
          ),
          SizedBox(
            height: 15 * h,
          ),
          Container(
            height: 56 * h,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20 * w),
            margin: EdgeInsets.symmetric(horizontal: 25 * w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28 * h),
              color: AppColor.white,
            ),
            child: Center(
              child: TextField(
                controller: _username,
                onChanged: widget.username,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                  fontFamily: AppColor.fontFamily,
                  fontWeight: FontWeight.w600,
                  fontSize: 16 * h,
                  height: 25 / 16,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  hintText: 'Username',
                  hintStyle: TextStyle(
                    fontFamily: AppColor.fontFamily,
                    fontWeight: FontWeight.w400,
                    fontSize: 14 * h,
                    height: 25 / 14,
                    color: AppColor.grey.withOpacity(0.8),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 35 * h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 25 * h),
            child: Text(
              'Phone Number',
              style: TextStyle(
                fontFamily: AppColor.fontFamily,
                fontWeight: FontWeight.w600,
                fontSize: 16 * h,
                height: 27 / 16,
                color: AppColor.dark,
              ),
            ),
          ),
          SizedBox(
            height: 15 * h,
          ),
          Container(
            height: 56 * h,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20 * w),
            margin: EdgeInsets.symmetric(horizontal: 25 * w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28 * h),
              color: AppColor.white,
            ),
            child: Center(
              child: TextField(
                controller: _phone,
                onChanged: widget.phone,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                  fontFamily: AppColor.fontFamily,
                  fontWeight: FontWeight.w600,
                  fontSize: 16 * h,
                  height: 25 / 16,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  hintText: 'Phone Number',
                  hintStyle: TextStyle(
                    fontFamily: AppColor.fontFamily,
                    fontWeight: FontWeight.w400,
                    fontSize: 14 * h,
                    height: 25 / 14,
                    color: AppColor.grey.withOpacity(0.8),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 35 * h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 25 * h),
            child: Text(
              'Password',
              style: TextStyle(
                fontFamily: AppColor.fontFamily,
                fontWeight: FontWeight.w600,
                fontSize: 16 * h,
                height: 27 / 16,
                color: AppColor.dark,
              ),
            ),
          ),
          SizedBox(
            height: 15 * h,
          ),
          Container(
            height: 56 * h,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20 * w),
            margin: EdgeInsets.symmetric(horizontal: 25 * w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28 * h),
              color: AppColor.white,
            ),
            child: Center(
              child: TextField(
                controller: _password,
                textInputAction: TextInputAction.done,
                onChanged: widget.password,
                autocorrect: false,
                obscureText: k,
                style: TextStyle(
                  fontFamily: AppColor.fontFamily,
                  fontWeight: FontWeight.w600,
                  fontSize: 16 * h,
                  height: 25 / 16,
                ),
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      k = !k;
                      setState(() {});
                    },
                    child: k
                        ? SvgPicture.asset(
                            'assets/icons/eye.svg',
                            fit: BoxFit.none,
                          )
                        : SvgPicture.asset(
                            'assets/icons/eye-off.svg',
                            fit: BoxFit.none,
                          ),
                  ),
                  border: InputBorder.none,
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    fontFamily: AppColor.fontFamily,
                    fontWeight: FontWeight.w400,
                    fontSize: 14 * h,
                    height: 25 / 14,
                    color: AppColor.grey.withOpacity(0.8),
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
