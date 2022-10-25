import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:zet_fire/src/bloc/follower_bloc.dart';
import 'package:zet_fire/src/bloc/profile_bloc.dart';
import 'package:zet_fire/src/cloud_firestore/user_cloud_fire.dart';
import 'package:zet_fire/src/model/follower_model.dart';
import 'package:zet_fire/src/model/profile_model.dart';
import 'package:zet_fire/src/model/user_model.dart';

class UserBloc {
  final UsersCloudFire cloudFireUser = UsersCloudFire();
  final _fetchUser = PublishSubject<ProfileModel>();

  Stream<ProfileModel> get getUser => _fetchUser.stream;

  userInfo(String phone, String myPhone) async {
    ProfileModel data = await profileBloc.userInfo(phone);
    FollowerModel follower = await followerBloc.isFollowed(myPhone, phone);
    if (follower.id != '') {
      data.isFollowed = true;
      data.id = follower.id;
    } else {
      data.isFollowed = false;
    }
    _fetchUser.sink.add(data);
  }

  Future<UserModel> getUserInfo(String phoneNumber) async {
    List<UserModel> data = await cloudFireUser.getUsers(phoneNumber);
    try {
      return data.first;
    } catch (_) {
      return UserModel.fromJson({});
    }
  }
}

final userBloc = UserBloc();
