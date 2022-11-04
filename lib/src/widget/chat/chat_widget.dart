import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zet_fire/src/bloc/all_chats_bloc.dart';
import 'package:zet_fire/src/bloc/user_bloc.dart';
import 'package:zet_fire/src/colors/app_color.dart';
import 'package:zet_fire/src/model/chat_model.dart';
import 'package:zet_fire/src/model/user_model.dart';
import 'package:zet_fire/src/utils/utils.dart';
import 'package:zet_fire/src/widget/app/custom_network_image.dart';

class ChatWidget extends StatefulWidget {
  final String userPhone;
  final String myPhone;

  const ChatWidget({Key? key, required this.userPhone, required this.myPhone})
      : super(key: key);

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  UserModel userModel = UserModel.fromJson({});
  ChatModel chatModel = ChatModel.fromJson({});

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 52 * h,
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(horizontal: 25 * w),
      child: Row(
        children: [
          userModel.userPhoto != ''
              ? CustomNetworkImage(
                  image: userModel.userPhoto,
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
                  userModel.name,
                  style: TextStyle(
                    fontFamily: AppColor.fontFamily,
                    fontWeight: FontWeight.w700,
                    fontSize: 16 * h,
                    color: AppColor.dark,
                  ),
                ),
                const Spacer(),
                Text(
                  chatModel.lastMessage,
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

  Future<void> _getData() async {
    userModel = await userBloc.getUserInfo(widget.userPhone);
    chatModel = await allChatsBloc.chatExists(widget.userPhone, widget.myPhone);
    if (mounted) {
      setState(() {});
    }
  }
}
