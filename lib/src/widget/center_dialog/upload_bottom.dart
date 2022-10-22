import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zet_fire/src/colors/app_color.dart';

class UploadBottomWidget {
  static void uploadWidget(
    BuildContext context,
    double h,
    double w,
    Function(String caption) caption,
  ) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 16 * h),
        height: MediaQuery.of(context).size.height * (4 / 5),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            topLeft: Radius.circular(8),
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 16 * h,
            ),
            Container(
              width: 114 * h,
              height: 5 * h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: AppColor.dark.withOpacity(0.1),
              ),
            ),
            SizedBox(
              height: 30 * h,
            ),
            Text(
              'Write a caption',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: AppColor.fontFamily,
                fontWeight: FontWeight.w600,
                fontSize: 20 * h,
                color: AppColor.dark,
              ),
            ),
            SizedBox(
              height: 20 * h,
            ),
            TextField(
              maxLines: 5,
              onChanged: caption,
              style: TextStyle(
                fontFamily: AppColor.fontFamily,
                fontWeight: FontWeight.w400,
                fontSize: 16 * h,
                color: AppColor.dark,
              ),
              decoration: InputDecoration(
                hintText: 'Enter your caption here ...',
                hintStyle: TextStyle(
                  fontFamily: AppColor.fontFamily,
                  fontWeight: FontWeight.w400,
                  fontSize: 16 * h,
                  color: AppColor.dark.withOpacity(0.5),
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 56 * h,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(
                    horizontal: 16 * h,
                    vertical: Platform.isIOS ? 24 * h : 16 * h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColor.blue,
                ),
                child: Center(
                  child: Text(
                    'Done',
                    style: TextStyle(
                      fontFamily: AppColor.fontFamily,
                      fontWeight: FontWeight.w400,
                      fontSize: 20 * h,
                      color: AppColor.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
