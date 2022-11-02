import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zet_fire/src/bloc/all_chats_bloc.dart';
import 'package:zet_fire/src/bloc/messages_bloc.dart';
import 'package:zet_fire/src/bloc/user_bloc.dart';
import 'package:zet_fire/src/colors/app_color.dart';
import 'package:zet_fire/src/model/message_model.dart';
import 'package:zet_fire/src/model/user_model.dart';
import 'package:zet_fire/src/utils/utils.dart';
import 'package:zet_fire/src/widget/app/custom_network_image.dart';
import 'package:zet_fire/src/widget/chat/message_widget.dart';

class ChatScreen extends StatefulWidget {
  final String userPhone;

  const ChatScreen({
    Key? key,
    required this.userPhone,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();
  UserModel user = UserModel.fromJson({});
  bool controllerIsEmpty = true;
  String chatId = '';

  @override
  void initState() {
    super.initState();
    _getData();
    messagesBloc.allMessages(widget.userPhone);
    controller.addListener(() {
      if (controller.text != '') {
        controllerIsEmpty = false;
        setState(() {});
      } else {
        controllerIsEmpty = true;
        setState(() {});
      }
    });
  }

  Future<void> _getData() async {
    user = await userBloc.getUserInfo(widget.userPhone);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return Scaffold(
      backgroundColor: AppColor.screen,
      appBar: AppBar(
        backgroundColor: AppColor.appbar,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            color: Colors.transparent,
            child: SvgPicture.asset(
              'assets/icons/arrow_left.svg',
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        elevation: 0,
        title: Row(
          children: [
            user.userPhoto != ' '
                ? CustomNetworkImage(
                    image: user.userPhoto,
                    height: 48 * h,
                    width: 48 * h,
                    boxFit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(52),
                  )
                : Container(
                    height: 48 * h,
                    width: 48 * h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(52),
                      border: Border.all(color: AppColor.grey),
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/user.svg',
                      fit: BoxFit.scaleDown,
                      color: AppColor.dark.withOpacity(0.4),
                    ),
                  ),
            SizedBox(
              width: 16 * w,
            ),
            user.name != ''
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16 * h,
                          color: AppColor.dark,
                        ),
                      ),
                      SizedBox(
                        height: 2 * h,
                      ),
                      Text(
                        user.userName,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14 * h,
                          color: AppColor.dark.withOpacity(0.6),
                        ),
                      ),
                    ],
                  )
                : Text(
                    user.userName,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14 * h,
                      color: AppColor.dark.withOpacity(0.6),
                    ),
                  ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
              stream: messagesBloc.getMessages,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<MessageModel> msg = snapshot.data!;
                  chatId = msg.first.chatId;
                  return ListView.builder(
                    itemCount: msg.length,
                    itemBuilder: (context, index) {
                      return MessageWidget(
                        text: msg[index].text,
                        fromMe: msg[index].fromMe,
                        date: msg[index].time,
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            height: 24 * h,
                            width: MediaQuery.of(context).size.width,
                            color: AppColor.yellow,
                          ),
                          SizedBox(
                            height: 50 * h,
                          )
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
              left: 25 * w,
              right: 25 * w,
              top: 12 * h,
              bottom: Platform.isIOS ? 24 * h : 16 * h,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20 * w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              color: AppColor.grey.withOpacity(0.2),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/smile.svg',
                  height: 26 * h,
                  width: 26 * h,
                ),
                SizedBox(
                  width: 14 * w,
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14 * h,
                      color: AppColor.dark,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type your message ...',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14 * h,
                        color: AppColor.dark.withOpacity(0.4),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 14 * w,
                ),
                GestureDetector(
                  onTap: () async {
                    if (controller.text.isNotEmpty) {
                      if (chatId != '') {
                        messagesBloc.createMessage(
                            controller.text, chatId, widget.userPhone);
                        controller.text = '';
                      } else {
                        String id =
                            await allChatsBloc.createChat(widget.userPhone);
                        messagesBloc.createMessage(
                            controller.text, id, widget.userPhone);
                        controller.text = '';
                      }
                    }
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: SvgPicture.asset(
                      'assets/icons/send.svg',
                      height: 26 * h,
                      width: 26 * h,
                      color: controllerIsEmpty ? AppColor.dark : AppColor.blue,
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
}
