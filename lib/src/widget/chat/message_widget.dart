import 'package:flutter/material.dart';
import 'package:zet_fire/src/colors/app_color.dart';
import 'package:zet_fire/src/utils/utils.dart';

class MessageWidget extends StatelessWidget {
  final String text;
  final bool fromMe;
  final int date;

  const MessageWidget({
    Key? key,
    required this.text,
    required this.fromMe,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(date);
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24 * w),
      child: fromMe
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${time.hour}.${time.minute}',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14 * h,
                    color: AppColor.grey,
                  ),
                ),
                SizedBox(
                  width: 24 * w,
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20 * w,
                      vertical: 15 * h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                      color: AppColor.blue,
                    ),
                    child: Text(
                      text,
                      maxLines: 4,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14 * h,
                        color: fromMe ? AppColor.white : AppColor.dark,
                      ),
                    ),
                  ),
                )
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20 * w,
                      vertical: 15 * h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                      color: AppColor.white,
                    ),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14 * h,
                        color: AppColor.dark,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 24 * w,
                ),
                Text(
                  '${time.hour}.${time.minute}',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14 * h,
                    color: AppColor.grey,
                  ),
                ),
              ],
            ),
    );
  }
}
