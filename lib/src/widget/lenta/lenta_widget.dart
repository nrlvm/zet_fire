import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:zet_fire/src/bloc/user_bloc.dart';
import 'package:zet_fire/src/colors/app_color.dart';
import 'package:zet_fire/src/model/lenta_model.dart';
import 'package:zet_fire/src/model/user_model.dart';
import 'package:zet_fire/src/ui/main/profile/profile_screen.dart';
import 'package:zet_fire/src/utils/utils.dart';
import 'package:zet_fire/src/widget/app/custom_network_image.dart';

class LentaWidget extends StatefulWidget {
  final LentaModel data;
  final Function()onTap;

  const LentaWidget({Key? key, required this.data, required this.onTap, }) : super(key: key);

  @override
  State<LentaWidget> createState() => _LentaWidgetState();
}

class _LentaWidgetState extends State<LentaWidget> {
  UserModel userModel = UserModel.fromJson({});

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(widget.data.time);
    String date = DateFormat('dd-MMM-yyy').format(time);
    double h = Utils.height(context);
    double w = Utils.width(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
        left: 25 * w,
        right: 25 * w,
        bottom: 20 * h,
      ),
      padding: EdgeInsets.only(
        left: 15 * w,
        right: 15 * w,
        bottom: 20 * h,
        top: 17 * h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColor.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              userModel.userPhoto == ''
                  ? Container(
                      height: 42 * h,
                      width: 42 * h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(42),
                        border: Border.all(
                          color: AppColor.dark.withOpacity(0.5),
                          width: 0.5,
                        ),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/user.svg',
                        // height: 8 * h,
                        // width: 8 * h,
                        fit: BoxFit.scaleDown,
                        color: AppColor.dark.withOpacity(0.2),
                      ),
                    )
                  : CustomNetworkImage(
                      height: 42 * h,
                      width: 42 * h,
                      borderRadius: BorderRadius.circular(42),
                      image: userModel.userPhoto,
                    ),
              SizedBox(
                width: 18 * w,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: widget.onTap,
                  child: Container(
                    color: Colors.transparent,
                    alignment: AlignmentDirectional.centerStart,
                    height: 36 * h,
                    child: Text(
                      userModel.userName,
                      style: TextStyle(
                        fontFamily: AppColor.fontFamily,
                        fontWeight: FontWeight.w700,
                        fontSize: 16 * h,
                        height: 25 / 16,
                        color: AppColor.dark,
                      ),
                    ),
                  ),
                ),
              ),
              SvgPicture.asset(
                'assets/icons/more.svg',
                alignment: AlignmentDirectional.centerEnd,
              ),
            ],
          ),
          SizedBox(
            height: 17 * h,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 2,
            // margin: EdgeInsets.symmetric(horizontal: 20 * w),
            color: AppColor.dark.withOpacity(0.1),
          ),
          SizedBox(
            height: 20 * h,
          ),
          Text(
            widget.data.caption,
            style: TextStyle(
              fontFamily: AppColor.fontFamily,
              fontWeight: FontWeight.w400,
              fontSize: 14 * h,
              height: 24 / 14,
              color: AppColor.dark,
            ),
          ),
          SizedBox(
            height: 20 * h,
          ),
          CustomNetworkImage(
            image: widget.data.url,
            borderRadius: BorderRadius.circular(10),
          ),
          SizedBox(
            height: 20 * h,
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/heart.svg',
                height: 24 * h,
                width: 24 * h,
                color: AppColor.dark.withOpacity(0.8),
              ),
              SizedBox(
                width: 8 * h,
              ),
              Text(
                widget.data.likeCount.toString(),
                style: TextStyle(
                  fontFamily: AppColor.fontFamily,
                  fontWeight: FontWeight.w600,
                  fontSize: 14 * h,
                  height: 24 / 14,
                  color: AppColor.dark.withOpacity(0.8),
                ),
              ),
              SizedBox(
                width: 24 * w,
              ),
              SvgPicture.asset(
                'assets/icons/message.svg',
                height: 24 * h,
                width: 24 * h,
                color: AppColor.dark.withOpacity(0.8),
              ),
              SizedBox(
                width: 8 * h,
              ),
              Text(
                widget.data.commentCount.toString(),
                style: TextStyle(
                  fontFamily: AppColor.fontFamily,
                  fontWeight: FontWeight.w600,
                  fontSize: 14 * h,
                  height: 24 / 14,
                  color: AppColor.dark.withOpacity(0.8),
                ),
              ),
              const Spacer(),
              Text(
                date,
                style: TextStyle(
                  fontFamily: AppColor.fontFamily,
                  fontWeight: FontWeight.w400,
                  fontSize: 13 * h,
                  height: 24 / 13,
                  color: AppColor.grey,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<void> _getData() async {
    userModel = await userBloc.getUserInfo(widget.data.userPhone);
    setState(() {});
  }
}
