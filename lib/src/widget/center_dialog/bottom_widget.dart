import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zet_fire/src/colors/app_color.dart';

class BottomWidget {
  static void modalBottom(
    String title,
    String msg,
    double h,
    double w,
    BuildContext context,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        width: MediaQuery.of(context).size.width,
        height: 487 * h,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(25),
          ),
          color: AppColor.appbar,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 15 * h,
            ),
            Container(
              height: 5 * h,
              width: 114 * w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: AppColor.grey.withOpacity(0.2),
              ),
            ),
            SizedBox(
              height: 50 * h,
            ),
            SvgPicture.asset('assets/icons/failed.svg'),
            SizedBox(
              height: 45 * h,
            ),
            Text(
              title,
              style: TextStyle(
                fontFamily: AppColor.fontFamily,
                fontWeight: FontWeight.w700,
                fontSize: 24 * h,
                height: 32.74 / 24,
                color: AppColor.dark,
              ),
            ),
            SizedBox(
              height: 20 * h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25 * w),
              child: Text(
                msg,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: AppColor.fontFamily,
                  fontSize: 16 * h,
                  height: 26 / 16,
                  color: AppColor.dark.withOpacity(0.8),
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 25 * w),
                width: MediaQuery.of(context).size.width,
                height: 56 * h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: AppColor.blue,
                ),
                child: Center(
                  child: Text(
                    'Try Again',
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
            SizedBox(
              height: 74 * h,
            ),
          ],
        ),
      ),
    );
  }
}
