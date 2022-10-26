import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zet_fire/src/colors/app_color.dart';
import 'package:zet_fire/src/model/user_model.dart';
import 'package:zet_fire/src/utils/utils.dart';
import 'package:zet_fire/src/widget/app/custom_network_image.dart';

class FollowersWidget extends StatelessWidget {
  final UserModel user;
  final Function() onTap;

  const FollowersWidget({
    Key? key,
    required this.user,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 16 * w, right: 16 * w, bottom: 16 * h),
        padding: EdgeInsets.symmetric(horizontal: 16 * w, vertical: 12 * h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColor.dark.withOpacity(0.2),
            width: 2,
          ),
          color: AppColor.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            user.userPhoto.isNotEmpty
                ? CustomNetworkImage(
                    height: 36 * h,
                    width: 36 * h,
                    image: user.userPhoto,
                    boxFit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(36),
                  )
                : Container(
                    height: 36 * h,
                    width: 36 * h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(36),
                      border: Border.all(
                        color: AppColor.dark.withOpacity(0.5),
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/user.svg',
                        height: 36 * h,
                        width: 36 * h,
                        fit: BoxFit.scaleDown,
                        color: AppColor.dark.withOpacity(0.2),
                      ),
                    ),
                  ),
            SizedBox(
              width: 14 * h,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name == ''? 'No name':user.name,
                    style: TextStyle(
                      fontFamily: AppColor.fontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 16 * h,
                      color: AppColor.dark,
                    ),
                  ),
                  SizedBox(
                    height: 4 * h,
                  ),
                  Text(
                    user.userName,
                    style: TextStyle(
                      fontFamily: AppColor.fontFamily,
                      fontWeight: FontWeight.w500,
                      fontSize: 16 * h,
                      color: AppColor.dark.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
