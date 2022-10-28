import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:zet_fire/src/bloc/user_bloc.dart';
import 'package:zet_fire/src/colors/app_color.dart';
import 'package:zet_fire/src/model/comment_model.dart';
import 'package:zet_fire/src/model/user_model.dart';
import 'package:zet_fire/src/utils/utils.dart';
import 'package:zet_fire/src/widget/app/custom_network_image.dart';

class CommentWidget extends StatefulWidget {
  final CommentModel model;

  const CommentWidget({Key? key, required this.model}) : super(key: key);

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  UserModel user = UserModel.fromJson({});


  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(widget.model.time);
    String date = DateFormat('dd-MMM-yyy').format(time);
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 24 * w, vertical: 12 * h),
      padding: EdgeInsets.symmetric(horizontal: 12 * w, vertical: 12 * h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.grey, width: 0.5),
      ),
      child: Row(
        children: [
          user.userPhoto == ''
              ? Container(
                  height: 38 * h,
                  width: 38 * h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(38),
                    border: Border.all(color: AppColor.grey.withOpacity(0.6)),
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/user.svg',
                    fit: BoxFit.scaleDown,
                    color: AppColor.dark.withOpacity(0.4),
                  ),
                )
              : CustomNetworkImage(
                  image: user.userPhoto,
                  height: 38 * h,
                  width: 38 * h,
                  boxFit: BoxFit.cover,
                  borderRadius: BorderRadius.circular(38),
                ),
          SizedBox(
            width: 14 * w,
          ),
          Expanded(
            child: Text.rich(
              TextSpan(
                style: TextStyle(
                  fontFamily: AppColor.fontFamily,
                  fontSize: 14 * h,
                ),
                children: [
                  TextSpan(
                    text: '${user.userName} ',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: widget.model.comment,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: '\n$date',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getData() async {
    user = await userBloc.getUserInfo(widget.model.userPhone);
    setState(() {});
  }
}
