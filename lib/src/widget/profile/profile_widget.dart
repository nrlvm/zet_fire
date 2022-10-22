import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zet_fire/src/colors/app_color.dart';
import 'package:zet_fire/src/model/user_model.dart';
import 'package:zet_fire/src/utils/utils.dart';
import 'package:zet_fire/src/widget/app/custom_network_image.dart';

class ProfileWidget extends StatelessWidget {
  final UserModel data;
  final int publications;
  final Function() onTap;
  final Function() follow;
  final bool isLoading;
  final bool myProfile;
  final bool isFollowed;

  const ProfileWidget({
    Key? key,
    required this.data,
    required this.publications,
    required this.onTap,
    required this.isLoading,
    required this.myProfile,
    required this.isFollowed,
    required this.follow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
        left: 25 * w,
        right: 25 * w,
        top: 35 * h,
        bottom: 30 * h,
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 86 * h,
                width: 86 * h,
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(86),
                        border: Border.all(
                          color: AppColor.dark.withOpacity(0.5),
                        ),
                      ),
                      child: data.userPhoto == ''
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
                              height: 86 * h,
                              width: 86 * h,
                              image: data.userPhoto,
                              boxFit: BoxFit.cover,
                            ),
                    ),
                    myProfile == true
                        ? GestureDetector(
                            onTap: onTap,
                            child: Container(
                              height: 36 * h,
                              width: 36 * h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(36),
                                border: Border.all(
                                  width: 2,
                                  color: AppColor.white,
                                ),
                                color: AppColor.blue,
                              ),
                              child: Center(
                                child: isLoading
                                    ? SizedBox(
                                        height: 18 * h,
                                        width: 18 * h,
                                        child: CircularProgressIndicator(
                                          color: AppColor.white,
                                          strokeWidth: 1,
                                        ),
                                      )
                                    : SvgPicture.asset(
                                        'assets/icons/camera.svg',
                                        height: 20 * h,
                                        width: 20 * h,
                                      ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              SizedBox(
                width: 25 * w,
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name.isEmpty ? 'Set Name' : data.name,
                    style: TextStyle(
                      fontFamily: AppColor.fontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 20 * h,
                      height: 33 / 20,
                      decoration: data.name.isEmpty
                          ? TextDecoration.underline
                          : TextDecoration.none,
                      color: data.name.isEmpty
                          ? AppColor.dark.withOpacity(0.4)
                          : AppColor.dark,
                    ),
                  ),
                  Text(
                    data.userName,
                    style: TextStyle(
                      fontFamily: AppColor.fontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 16 * h,
                      height: 27 / 16,
                      color: AppColor.dark.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(
                    height: 6 * h,
                  ),
                  Text(
                    data.city.isEmpty ? 'not specified' : data.city,
                    style: TextStyle(
                      fontFamily: AppColor.fontFamily,
                      fontWeight: FontWeight.w400,
                      fontSize: 14 * h,
                      height: 24 / 14,
                      color: AppColor.dark.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 30 * h,
          ),
          myProfile == false
              ? Container(
                  height: 56 * h,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(bottom: 25 * h),
                  child: Row(
                    children: [
                      Container(
                        height: 56 * h,
                        width: 92 * w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28.5),
                          border: Border.all(
                            color: AppColor.blue,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/message.svg',
                            height: 28 * h,
                            width: 28 * h,
                            fit: BoxFit.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 25 * w,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: follow,
                          child: Container(
                            height: 56,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28.5),
                              color: isFollowed
                                  ? Colors.transparent
                                  : AppColor.blue,
                              border:
                                  Border.all(color: AppColor.blue, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                isFollowed == true ? 'Following' : 'Follow',
                                style: TextStyle(
                                  fontFamily: AppColor.fontFamily,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18 * h,
                                  color: isFollowed == true
                                      ? AppColor.dark
                                      : AppColor.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : SizedBox(),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 18 * h,
              horizontal: 24 * w,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        publications.toString(),
                        style: TextStyle(
                          fontFamily: AppColor.fontFamily,
                          fontWeight: FontWeight.w700,
                          fontSize: 20 * h,
                          height: 33 / 20,
                          color: AppColor.dark,
                        ),
                      ),
                      Text(
                        'Publications',
                        style: TextStyle(
                          fontFamily: AppColor.fontFamily,
                          fontWeight: FontWeight.w400,
                          fontSize: 14 * h,
                          height: 24 / 14,
                          color: AppColor.dark.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        data.followersCount.toString(),
                        style: TextStyle(
                          fontFamily: AppColor.fontFamily,
                          fontWeight: FontWeight.w700,
                          fontSize: 20 * h,
                          height: 33 / 20,
                          color: AppColor.dark,
                        ),
                      ),
                      Text(
                        'Followers',
                        style: TextStyle(
                          fontFamily: AppColor.fontFamily,
                          fontWeight: FontWeight.w400,
                          fontSize: 14 * h,
                          height: 24 / 14,
                          color: AppColor.dark.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        data.followingCount.toString(),
                        style: TextStyle(
                          fontFamily: AppColor.fontFamily,
                          fontWeight: FontWeight.w700,
                          fontSize: 20 * h,
                          height: 33 / 20,
                          color: AppColor.dark,
                        ),
                      ),
                      Text(
                        'Following',
                        style: TextStyle(
                          fontFamily: AppColor.fontFamily,
                          fontWeight: FontWeight.w400,
                          fontSize: 14 * h,
                          height: 24 / 14,
                          color: AppColor.dark.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
