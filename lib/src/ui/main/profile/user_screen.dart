import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zet_fire/src/bloc/follower_bloc.dart';
import 'package:zet_fire/src/bloc/user_bloc.dart';
import 'package:zet_fire/src/colors/app_color.dart';
import 'package:zet_fire/src/model/profile_model.dart';
import 'package:zet_fire/src/ui/follow/followers_screen.dart';
import 'package:zet_fire/src/utils/utils.dart';
import 'package:zet_fire/src/widget/app/custom_network_image.dart';
import 'package:zet_fire/src/widget/profile/profile_widget.dart';

class UserScreen extends StatefulWidget {
  final String userPhoneNumber;
  final String myPhoneNumber;

  const UserScreen({
    Key? key,
    required this.userPhoneNumber,
    required this.myPhoneNumber,
  }) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _gridCount = 2;
  final refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    userBloc.userInfo(widget.userPhoneNumber, widget.myPhoneNumber);
    super.initState();
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
          'Profile',
          style: TextStyle(
            fontFamily: AppColor.fontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 28 * h,
            color: AppColor.dark,
          ),
        ),
      ),
      body: StreamBuilder<ProfileModel>(
        stream: userBloc.getUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ProfileModel profileModel = snapshot.data!;
            return SmartRefresher(
              controller: refreshController,
              onRefresh: _onRefresh,
              header: const WaterDropMaterialHeader(),
              child: ListView(
                children: [
                  ProfileWidget(
                    myPhone: widget.myPhoneNumber,
                    userModel: profileModel.user,
                    publicationCount: profileModel.lenta.length,
                    changePhoto: () {},
                    isLoading: false,
                    myProfile: false,
                    isFollowed: profileModel.isFollowed,
                    follow: () {
                      profileModel.isFollowed = !profileModel.isFollowed;
                      if (profileModel.isFollowed == false) {
                        followerBloc.unFollow(profileModel.id);
                      } else {
                        followerBloc.follow(
                          widget.myPhoneNumber,
                          widget.userPhoneNumber,
                        );
                      }
                      setState(() {});
                    },
                    onTapFollowing: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FollowerScreen(
                            phoneNumber: widget.userPhoneNumber,
                            following: true,
                          ),
                        ),
                      );
                    },
                    onTapFollowers: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FollowerScreen(
                            phoneNumber: widget.userPhoneNumber,
                            following: false,
                          ),
                        ),
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: (profileModel.lenta.length + _gridCount + 1) ~/
                        _gridCount,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25 * w),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: index * _gridCount >=
                                        profileModel.lenta.length
                                    ? Container()
                                    : CustomNetworkImage(
                                        height: 150 * h,
                                        width: 150 * h,
                                        borderRadius: BorderRadius.circular(10),
                                        image: profileModel
                                            .lenta[index * _gridCount].url,
                                      ),
                              ),
                              SizedBox(
                                width: 25 * w,
                              ),
                              Expanded(
                                child: index * _gridCount + 1 >=
                                        profileModel.lenta.length
                                    ? Container()
                                    : CustomNetworkImage(
                                        height: 150 * h,
                                        width: 150 * h,
                                        borderRadius: BorderRadius.circular(10),
                                        image: profileModel
                                            .lenta[index * _gridCount + 1].url,
                                      ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25 * h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: SizedBox(
              height: 36 * h,
              width: 36 * h,
              child: const CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  _onRefresh() async {
    userBloc.userInfo(widget.userPhoneNumber, widget.myPhoneNumber);
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
  }
}
