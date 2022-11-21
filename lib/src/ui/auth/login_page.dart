import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zet_fire/src/colors/app_color.dart';
import 'package:zet_fire/src/utils/utils.dart';

class LoginPage extends StatefulWidget {
  final Function(String phone) phone;
  final Function(String password) password;
  final Function() signGoogle;

  const LoginPage({
    Key? key,
    required this.phone,
    required this.password,
    required this.signGoogle,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool k = true;

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      backgroundColor: AppColor.appbar,
      body: ListView(
        children: [
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
              child: TextFormField(
                keyboardType: TextInputType.phone,
                controller: _phoneNumber,
                textInputAction: TextInputAction.next,
                onChanged: widget.phone,
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
                    )),
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
                autocorrect: false,
                onChanged: widget.password,
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
          SizedBox(
            height: 24 * h,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 2,
                  color: AppColor.grey.withOpacity(0.3),
                  margin: EdgeInsets.symmetric(horizontal: 20 * w),
                ),
              ),
              Text(
                'Or login with',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14 * h,
                ),
              ),
              Expanded(
                child: Container(
                  height: 2,
                  color: AppColor.grey.withOpacity(0.3),
                  margin: EdgeInsets.symmetric(horizontal: 20 * w),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20 * h,
          ),
          GestureDetector(
            onTap: widget.signGoogle,
            child: Container(
              height: 56 * h,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20 * w),
              margin: EdgeInsets.symmetric(horizontal: 25 * w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28 * h),
                color: AppColor.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/icons/google.svg'),
                  SizedBox(
                    width: 16 * w,
                  ),
                  Text(
                    'Google',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18 * h,
                      color: AppColor.dark,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
