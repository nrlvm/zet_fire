import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zet_fire/src/bloc/follower_bloc.dart';
import 'package:zet_fire/src/colors/app_color.dart';
import 'package:zet_fire/src/model/follower_model.dart';
import 'package:zet_fire/src/ui/main/profile/profile_screen.dart';
import 'package:zet_fire/src/utils/utils.dart';

class FollowerScreen extends StatefulWidget {
  final String phoneNumber;

  const FollowerScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<FollowerScreen> createState() => _FollowerScreenState();
}

class _FollowerScreenState extends State<FollowerScreen> {
  @override
  void initState() {
    followerBloc.getAllFollowers(widget.phoneNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    return Scaffold(
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
          'Following',
          style: TextStyle(
            fontFamily: AppColor.fontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 28 * h,
            color: AppColor.dark,
          ),
        ),
      ),
      body: StreamBuilder<List<FollowerModel>>(
        stream: followerBloc.getFollowers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<FollowerModel> data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MyProfileScreen(
                          phone: data[index].user1,
                          phoneMe: data[index].user2,
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  height: 56 * h,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 25 * h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColor.dark.withOpacity(0.7),
                  ),
                  child: Column(
                    children: [
                      Text(
                        data[index].user1,
                      ),
                      Text(
                        data[index].user2,
                      ),
                      Text(
                        data[index].id,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
