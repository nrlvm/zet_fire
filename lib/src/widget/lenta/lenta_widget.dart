import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:zet_fire/src/bloc/user_bloc.dart';
import 'package:zet_fire/src/colors/app_color.dart';
import 'package:zet_fire/src/model/lenta_model.dart';
import 'package:zet_fire/src/model/user_model.dart';
import 'package:zet_fire/src/utils/utils.dart';
import 'package:zet_fire/src/widget/app/custom_network_image.dart';

class LentaWidget extends StatefulWidget {
  final LentaModel data;
  final Function() openUserProfile;
  final Function() openInfo;
  final Function() likeButton;
  final Function() moreButton;
  final bool lentaList;

  const LentaWidget({
    Key? key,
    required this.data,
    required this.openUserProfile,
    required this.openInfo,
    required this.likeButton,
    required this.moreButton,
    this.lentaList = true,
  }) : super(key: key);

  @override
  State<LentaWidget> createState() => _LentaWidgetState();
}

class _LentaWidgetState extends State<LentaWidget> {
  UserModel userModel = UserModel.fromJson({});
  late VideoPlayerController videoController;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _getData();
    videoController = VideoPlayerController.network(widget.data.url);
    videoController.initialize().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(widget.data.time);
    String date = DateFormat.yMMMMd().format(time);
    double h = Utils.height(context);
    double w = Utils.width(context);
    return GestureDetector(
      onTap: widget.openInfo,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(
          left: !widget.lentaList ? 0 : 25 * w,
          right: !widget.lentaList ? 0 : 25 * w,
          bottom: !widget.lentaList ? 0 : 20 * h,
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
            GestureDetector(
              onTap: widget.openUserProfile,
              child: Container(
                color: Colors.transparent,
                child: Row(
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
                    GestureDetector(
                      onTap: widget.moreButton,
                      child: Container(
                        height: 32 * h,
                        width: 32 * h,
                        color: Colors.transparent,
                        padding: EdgeInsets.symmetric(
                          horizontal: 4 * w,
                          vertical: 4 * h,
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/more.svg',
                          alignment: AlignmentDirectional.centerEnd,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12 * h,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 2,
              color: AppColor.dark.withOpacity(0.1),
            ),
            SizedBox(
              height: 12 * h,
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
              height: 12 * h,
            ),
            widget.data.contentType != 'video'
                ? CustomNetworkImage(
              image: widget.data.url,
              borderRadius: BorderRadius.circular(10),
            )
                : Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                GestureDetector(
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        isPlaying = !isPlaying;
                        isPlaying
                            ? videoController.pause()
                            : videoController.play();
                      });
                    }
                  },
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 2 / 3,
                    width: MediaQuery.of(context).size.width,
                    child: VideoPlayer(videoController),
                  ),
                ),
                VideoProgressIndicator(
                  videoController,
                  allowScrubbing: true,
                ),
              ],
            ),
            SizedBox(
              height: 20 * h,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: widget.likeButton,
                  child: Container(
                    height: 24 * h,
                    width: 24 * h,
                    color: Colors.transparent,
                    child: widget.data.likeId.isEmpty
                        ? SvgPicture.asset(
                            'assets/icons/heart.svg',
                            height: 24 * h,
                            width: 24 * h,
                            color: AppColor.dark.withOpacity(0.8),
                            fit: BoxFit.contain,
                          )
                        : SvgPicture.asset(
                            'assets/icons/filled_heart.svg',
                            height: 20 * h,
                            width: 20 * h,
                            color: AppColor.red,
                            fit: BoxFit.contain,
                          ),
                  ),
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
                  widget.data.commentData.length.toString(),
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
      ),
    );
  }

  Future<void> _getData() async {
    userModel = await userBloc.getUserInfo(widget.data.userPhone);
    if (mounted) {
      setState(() {});
    }
  }
}
