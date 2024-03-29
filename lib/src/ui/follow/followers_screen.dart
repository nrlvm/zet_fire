import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zet_fire/src/bloc/follower_bloc.dart';
import 'package:zet_fire/src/colors/app_color.dart';
import 'package:zet_fire/src/model/user_model.dart';
import 'package:zet_fire/src/ui/main/profile/user_screen.dart';
import 'package:zet_fire/src/utils/utils.dart';
import 'package:zet_fire/src/widget/followers/followers_widget.dart';

class FollowerScreen extends StatefulWidget {
  final String phoneNumber;
  final bool following;

  const FollowerScreen({
    Key? key,
    required this.phoneNumber,
    required this.following,
  }) : super(key: key);

  @override
  State<FollowerScreen> createState() => _FollowerScreenState();
}

class _FollowerScreenState extends State<FollowerScreen> {
  String myPhoneNumber = '';

  @override
  void initState() {
    if (widget.following == true) {
      followerBloc.getAllFollowings(widget.phoneNumber);
    } else {
      followerBloc.getAllFollowers(widget.phoneNumber);
    }
    getMyPhone();
    super.initState();
  }

  getMyPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    myPhoneNumber = prefs.getString('phone_number') ?? '';
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
          widget.following ? 'Following' : 'Followers',
          style: TextStyle(
            fontFamily: AppColor.fontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 28 * h,
            color: AppColor.dark,
          ),
        ),
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: widget.following
            ? followerBloc.getFollowing
            : followerBloc.getFollowers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<UserModel> data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              padding: EdgeInsets.only(top: 16 * h),
              itemBuilder: (context, index) => FollowersWidget(
                user: data[index],
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return UserScreen(
                          userPhoneNumber: data[index].phone,
                          myPhoneNumber: myPhoneNumber,
                        );
                      },
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(
              child: SizedBox(
                height: 36 * h,
                width: 36 * h,
                child: const CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
