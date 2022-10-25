import 'package:rxdart/subjects.dart';
import 'package:zet_fire/src/bloc/user_bloc.dart';
import 'package:zet_fire/src/cloud_firestore/follower_cloud_fire.dart';
import 'package:zet_fire/src/model/follower_model.dart';
import 'package:zet_fire/src/model/user_model.dart';

class FollowerBloc {
  final FollowerCloudFire fcf = FollowerCloudFire();

  final _fetchFollowing = PublishSubject<List<UserModel>>();
  final _fetchFollowers = PublishSubject<List<UserModel>>();

  Stream<List<UserModel>> get getFollowing => _fetchFollowing.stream;

  Stream<List<UserModel>> get getFollowers => _fetchFollowers.stream;

  getAllFollowings(String phone) async {
    List<FollowerModel> data = await fcf.allUser1(phone);
    List<UserModel> users = [];
    for (int i = 0; i < data.length; i++) {
      users.add(await userBloc.getUserInfo(data[i].user2));
    }
    _fetchFollowing.sink.add(users);
  }

  getAllFollowers(String phone) async {
    List<FollowerModel> data = await fcf.allUser2(phone);
    List<UserModel> users = [];
    for (int i = 0; i < data.length; i++) {
      users.add(await userBloc.getUserInfo(data[i].user1));
    }
    _fetchFollowers.sink.add(users);
  }

  follow(String myPhone, String phone) async {
    await fcf.follow(FollowerModel(user1: myPhone, user2: phone));
  }

  unFollow(String id) async {
    await fcf.unfollow(id);
  }

  Future<FollowerModel> isFollowed(String user1Phone, String user2Phone) async {
    List<FollowerModel> followers = await fcf.allUser2(user2Phone);
    FollowerModel returnValue = FollowerModel.fromJson({});
    for (int i = 0; i < followers.length; i++) {
      if (followers[i].user1 == user1Phone) {
        returnValue = followers[i];
      }
    }
    return returnValue;
  }
}

final followerBloc = FollowerBloc();
