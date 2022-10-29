import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zet_fire/src/colors/app_color.dart';
import 'package:zet_fire/src/utils/utils.dart';
import 'package:zet_fire/src/widget/app/custom_network_image.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hasImage = false;
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 52 * h,
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(horizontal: 25 * w),
      child: Row(
        children: [
          hasImage
              ? CustomNetworkImage(
                  image: 'image',
                  height: 52 * h,
                  width: 52 * h,
                  borderRadius: BorderRadius.circular(52),
                  boxFit: BoxFit.cover,
                )
              : Container(
                  height: 52 * h,
                  width: 52 * h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(52),
                    border: Border.all(
                      color: AppColor.grey.withOpacity(0.5),
                      width: 0.5,
                    ),
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/user.svg',
                    fit: BoxFit.scaleDown,
                  ),
                ),
          SizedBox(
            width: 16 * w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Michael Snow',
                  style: TextStyle(
                    fontFamily: AppColor.fontFamily,
                    fontWeight: FontWeight.w700,
                    fontSize: 16 * h,
                    color: AppColor.dark,
                  ),
                ),
                const Spacer(),
                Text(
                  'I’m at the office right now.',
                  style: TextStyle(
                    fontFamily: AppColor.fontFamily,
                    fontWeight: FontWeight.w600,
                    fontSize: 14 * h,
                    color: AppColor.dark.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 24 * h,
            width: 24 * h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: AppColor.blue,
            ),
            child: Center(
              child: Text(
                '2',
                style: TextStyle(
                  fontFamily: AppColor.fontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 14 * h,
                  color: AppColor.white,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 14 * w,
          ),
        ],
      ),
    );
  }
}
