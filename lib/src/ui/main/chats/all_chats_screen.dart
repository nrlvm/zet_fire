import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:zet_fire/src/colors/app_color.dart';
import 'package:zet_fire/src/widget/chat/chat_widget.dart';
import 'package:zet_fire/src/utils/utils.dart';

class AllChatsScreen extends StatefulWidget {
  const AllChatsScreen({Key? key}) : super(key: key);

  @override
  State<AllChatsScreen> createState() => _AllChatsScreenState();
}

class _AllChatsScreenState extends State<AllChatsScreen> {
  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    return Scaffold(
      backgroundColor: AppColor.screen,
      appBar: AppBar(
        backgroundColor: AppColor.appbar,
        elevation: 1,
        centerTitle: false,
        title: Text(
          'Chats',
          style: TextStyle(
            fontFamily: AppColor.fontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 28 * h,
            color: AppColor.dark,
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 30 * h),
        itemCount: 14,
        itemBuilder: (context, _) {
          return Column(
            children: [
              Slidable(
                endActionPane: ActionPane(
                  extentRatio: 0.2,
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.black,
                      icon: Icons.delete_outline,
                      label: 'Delete',
                      spacing: 100,
                      borderRadius: BorderRadius.circular(8),
                      onPressed: (context) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'Delete this chat?',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16 * h,
                                  height: 24 / 16,
                                  letterSpacing: 0.5,
                                  color: Colors.black,
                                ),
                              ),
                              actions: [
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'No',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12 * h,
                                      height: 18 / 12,
                                      letterSpacing: 0.5,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                OutlinedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12 * h,
                                      height: 18 / 12,
                                      letterSpacing: 0.5,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                child: const ChatWidget(),
              ),
              SizedBox(
                height: 40 * h,
              ),
            ],
          );
        },
      ),
    );
  }
}
