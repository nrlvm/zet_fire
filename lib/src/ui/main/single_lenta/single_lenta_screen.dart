import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zet_fire/src/bloc/comment_bloc.dart';
import 'package:zet_fire/src/cloud_firestore/like_cloud_fire.dart';
import 'package:zet_fire/src/colors/app_color.dart';
import 'package:zet_fire/src/model/lenta_model.dart';
import 'package:zet_fire/src/model/like_model.dart';
import 'package:zet_fire/src/utils/utils.dart';
import 'package:zet_fire/src/widget/lenta/comment_widget.dart';
import 'package:zet_fire/src/widget/lenta/lenta_widget.dart';

class SingleLentaScreen extends StatefulWidget {
  final LentaModel data;

  const SingleLentaScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<SingleLentaScreen> createState() => _SingleLentaScreenState();
}

class _SingleLentaScreenState extends State<SingleLentaScreen> {
  LentaModel data = LentaModel.fromJson({});
  final TextEditingController _controller = TextEditingController();
  final ScrollController scroller = ScrollController();
  String myPhone = '';

  @override
  void initState() {
    data = widget.data;
    commentBloc.allComments(data);
    getMyPhone();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            child: StreamBuilder<LentaModel>(
              stream: commentBloc.getComments,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  data = snapshot.data!;
                }
                return ListView.builder(
                  controller: scroller,
                  itemBuilder: (context, position) {
                    int index = position - 1;
                    if (position == 0) {
                      return LentaWidget(
                        key: Key(data.commentCount.toString()),
                        data: data,
                        openUserProfile: () {},
                        openInfo: () {},
                        lentaList: false,
                        likeButton: () async {
                          if (data.likeId.isEmpty) {
                            String id = await likeCloudFire.saveLike(
                              LikeModel(
                                postId: data.id,
                                userPhone: myPhone,
                                time: DateTime.now().millisecondsSinceEpoch,
                              ),
                            );
                            data.likeId = id;
                            data.likeCount++;
                          } else {

                            likeCloudFire.deleteLike(data.likeId);
                            data.likeId = '';
                            data.likeCount--;
                          }
                          setState(() {});
                        },
                      );
                    }
                    return CommentWidget(
                      model: data.commentData[index],
                    );
                  },
                  itemCount: data.commentData.length + 1,
                );
              },
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
                    controller: _controller,
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
                    if (_controller.text.isNotEmpty) {
                      commentBloc.saveComment(data, _controller.text);
                      _controller.clear();
                      scroller.jumpTo(scroller.position.maxScrollExtent);
                    }
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

  void getMyPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    myPhone = prefs.getString('phone_number') ?? '';
  }
}
