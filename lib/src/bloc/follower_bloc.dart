import 'package:rxdart/subjects.dart';
import 'package:zet_fire/src/cloud_firestore/follower_cloud_fire.dart';
import 'package:zet_fire/src/model/follower_model.dart';

class FollowerBloc {
  final FollowerCloudFire fcf = FollowerCloudFire();

  final _fetchFollower = PublishSubject<List<FollowerModel>>();

  Stream<List<FollowerModel>> get getFollowers => _fetchFollower.stream;

  getAllFollowers(String phone) async {
    List<FollowerModel> data = await fcf.allUser1(phone);
    _fetchFollower.sink.add(data);
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
