import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:zet_fire/src/bloc/comment_bloc.dart';
import 'package:zet_fire/src/bloc/user_bloc.dart';
import 'package:zet_fire/src/colors/app_color.dart';
import 'package:zet_fire/src/model/comment_model.dart';
import 'package:zet_fire/src/model/lenta_model.dart';
import 'package:zet_fire/src/model/user_model.dart';
import 'package:zet_fire/src/utils/utils.dart';
import 'package:zet_fire/src/widget/app/custom_network_image.dart';
import 'package:zet_fire/src/widget/lenta/comment_widget.dart';

class SingleLentaScreen extends StatefulWidget {
  final LentaModel data;

  const SingleLentaScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<SingleLentaScreen> createState() => _SingleLentaScreenState();
}

class _SingleLentaScreenState extends State<SingleLentaScreen> {
  UserModel user = UserModel.fromJson({});

  @override
  void initState() {
    _getData();
    commentBloc.allComments(widget.data.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(widget.data.time);
    String date = DateFormat('dd-MMM-yyy').format(time);
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            color: Colors.transparent,
            child: SvgPicture.asset(
              'assets/icons/arrow_left.svg',
              fit: BoxFit.none,
            ),
          ),
        ),
        backgroundColor: AppColor.appbar,
        elevation: 1,
        centerTitle: false,
        title: Text(
          'Publication',
          style: TextStyle(
            fontFamily: AppColor.fontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 28 * h,
            color: AppColor.dark,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16 * w, vertical: 12 * h),
                  child: Row(
                    children: [
                      user.userPhoto == ''
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
                              image: user.userPhoto,
                            ),
                      SizedBox(
                        width: 16 * w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            user.name.isNotEmpty
                                ? Text(
                                    user.name,
                                    style: TextStyle(
                                      fontFamily: AppColor.fontFamily,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16 * h,
                                      color: AppColor.dark,
                                    ),
                                  )
                                : const SizedBox(),
                            SizedBox(
                              height: 4 * h,
                            ),
                            Text(
                              user.userName,
                              style: TextStyle(
                                fontFamily: AppColor.fontFamily,
                                fontWeight: FontWeight.w500,
                                fontSize: 14 * h,
                                color: AppColor.dark.withOpacity(0.8),
                              ),
                            )
                          ],
                        ),
                      ),
                      SvgPicture.asset('assets/icons/more.svg'),
                    ],
                  ),
                ),
                CustomNetworkImage(
                  image: widget.data.url,
                  width: MediaQuery.of(context).size.width,
                  boxFit: BoxFit.fitHeight,
                ),
                SizedBox(
                  height: 12 * h,
                ),
                StreamBuilder<List<CommentModel>>(
                  stream: commentBloc.getComments,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<CommentModel> comments = snapshot.data!;
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16 * w),
                            child: Row(
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
                                // const Spacer(),
                                Text(
                                  date,
                                  style: TextStyle(
                                    fontFamily: AppColor.fontFamily,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13 * h,
                                    height: 24 / 13,
                                    color: AppColor.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: comments.length,
                              itemBuilder: (context, index) {
                                return CommentWidget(model: comments[index]);
                              },
                            ),
                          )
                        ],
                      );
                    }
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16 * w),
                      child: Row(
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
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          Container(
            height: 56 * h,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 16 * w),
            margin: EdgeInsets.only(
              left: 16 * w,
              right: 16 * w,
              top: 8 * h,
              bottom: Platform.isIOS ? 24 * h : 16 * h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: AppColor.grey.withOpacity(0.2),
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(
                      fontFamily: AppColor.fontFamily,
                      fontWeight: FontWeight.w500,
                      fontSize: 16 * h,
                      color: AppColor.dark,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Write comment here ...',
                      hintStyle: TextStyle(
                        fontFamily: AppColor.fontFamily,
                        fontWeight: FontWeight.w400,
                        fontSize: 14 * h,
                        color: AppColor.dark.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('asdadasd');
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: SvgPicture.asset(
                      'assets/icons/send.svg',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }

  Future<void> _getData() async {
    user = await userBloc.getUserInfo(widget.data.userPhone);
    setState(() {});
  }
}
