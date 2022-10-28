import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zet_fire/src/bloc/profile_bloc.dart';
import 'package:zet_fire/src/bloc/auth_bloc.dart';
import 'package:zet_fire/src/model/profile_model.dart';
import 'package:zet_fire/src/storage/storage_firebase.dart';
import 'package:zet_fire/src/ui/follow/followers_screen.dart';
import 'package:zet_fire/src/ui/main/profile/settings_screen.dart';
import 'package:zet_fire/src/ui/main/single_lenta/single_lenta_screen.dart';
import 'package:zet_fire/src/utils/utils.dart';
import 'package:zet_fire/src/widget/app/custom_network_image.dart';
import 'package:zet_fire/src/widget/profile/profile_widget.dart';
import 'package:zet_fire/src/colors/app_color.dart';

class MyProfileScreen extends StatefulWidget {
  // final String phone;
  final String phoneMe;

  const MyProfileScreen({
    Key? key,
    // required this.phone,
    required this.phoneMe,
  }) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final refreshController = RefreshController(initialRefresh: false);
  bool followed = false;
  final _gridCount = 2;
  bool loading = false;

  @override
  void initState() {
    profileBloc.allProfile(widget.phoneMe);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = Utils.height(context);
    double w = Utils.width(context);
    return StreamBuilder<ProfileModel>(
      stream: profileBloc.getProfile,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ProfileModel profile = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
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
              actions: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsScreen(
                          data: profile.user,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: SvgPicture.asset(
                      'assets/icons/settings.svg',
                      color: AppColor.dark,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16 * h,
                ),
              ],
            ),
            body: SmartRefresher(
              controller: refreshController,
              onRefresh: _onRefresh,
              header: const WaterDropMaterialHeader(),
              child: ListView(
                children: [
                  ProfileWidget(
                    isFollowed: followed,
                    myProfile: true,
                    userModel: profile.user,
                    publicationCount: profile.lenta.length,
                    isLoading: loading,
                    onTapFollowers: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FollowerScreen(
                            phoneNumber: widget.phoneMe,
                            following: false,
                          ),
                        ),
                      );
                    },
                    onTapFollowing: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FollowerScreen(
                            phoneNumber: widget.phoneMe,
                            following: true,
                          ),
                        ),
                      );
                    },
                    follow: () {},
                    changePhoto: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => CupertinoActionSheet(
                          title: Text(
                            'What would you like to do \nwith your profile photo?',
                            style: TextStyle(
                              fontFamily: AppColor.fontFamily,
                              fontWeight: FontWeight.w700,
                              fontSize: 16 * h,
                              color: AppColor.dark,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          actions: [
                            CupertinoActionSheetAction(
                              onPressed: () async {
                                loading = true;
                                setState(() {});
                                Navigator.pop(this.context);
                                image == null;
                                await pickImage();
                                if (image != null) {
                                  String url = await storageFirebase.upload(
                                    'user_photo',
                                    image!,
                                  );
                                  profile.user.userPhoto = url;
                                  authBloc.updateUser(profile.user);
                                  Timer(const Duration(milliseconds: 700), () {
                                    loading = false;
                                    setState(() {});
                                  });
                                }
                              },
                              child: const Text(
                                'Select New Photo',
                              ),
                            ),
                            CupertinoActionSheetAction(
                              onPressed: () {
                                if (profile.user.userPhoto != '') {
                                  loading = true;
                                  setState(() {});
                                  storageFirebase.deleteFile(
                                    profile.user.userPhoto,
                                  );
                                  profile.user.userPhoto = '';
                                  authBloc.updateUser(profile.user);
                                }
                                Navigator.pop(context);
                                loading = false;
                                setState(() {});
                              },
                              isDestructiveAction: true,
                              child: const Text(
                                'Delete Current Photo',
                              ),
                            ),
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                        ),
                      );
                    },
                  ),
                  profile.lenta.isNotEmpty
                      ? ListView.builder(
                          itemCount: (profile.lenta.length + _gridCount + 1) ~/
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
                                              profile.lenta.length
                                          ? Container()
                                          : CustomNetworkImage(
                                              height: 150 * h,
                                              width: 150 * h,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: profile
                                                  .lenta[index * _gridCount]
                                                  .url,
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SingleLentaScreen(
                                                      data: profile.lenta[
                                                          index * _gridCount],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                    ),
                                    SizedBox(
                                      width: 25 * w,
                                    ),
                                    Expanded(
                                      child: index * _gridCount + 1 >=
                                              profile.lenta.length
                                          ? Container()
                                          : CustomNetworkImage(
                                              height: 150 * h,
                                              width: 150 * h,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: profile
                                                  .lenta[index * _gridCount + 1]
                                                  .url,
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SingleLentaScreen(
                                                      data: profile.lenta[
                                                          index * _gridCount +
                                                              1],
                                                    ),
                                                  ),
                                                );
                                              },
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
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.appbar,
            elevation: 1,
            centerTitle: false,
            automaticallyImplyLeading: false,
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
          body: Center(
            child: SizedBox(
              height: 36 * h,
              width: 36 * h,
              child: const CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  XFile? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      setState(() {
        this.image = image;
      });
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Failed to pick img $e');
    }
  }

  _onRefresh() async {
    profileBloc.allProfile(widget.phoneMe);
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
  }
}
