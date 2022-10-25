import 'package:rxdart/rxdart.dart';
import 'package:zet_fire/src/cloud_firestore/follower_cloud_fire.dart';
import 'package:zet_fire/src/cloud_firestore/lenta_cloud_fire.dart';
import 'package:zet_fire/src/cloud_firestore/user_cloud_fire.dart';
import 'package:zet_fire/src/model/follower_model.dart';
import 'package:zet_fire/src/model/lenta_model.dart';
import 'package:zet_fire/src/model/profile_model.dart';
import 'package:zet_fire/src/model/user_model.dart';

class ProfileBloc {
  final FollowerCloudFire followerCF = FollowerCloudFire();
  final LentaCloudFire lentaCF = LentaCloudFire();
  final UsersCloudFire cloudFireUser = UsersCloudFire();
  final _fetchProfile = PublishSubject<ProfileModel>();

  Stream<ProfileModel> get getProfile => _fetchProfile.stream;

  allProfile(String phone) async {
    ProfileModel data = await userInfo(phone);
    _fetchProfile.sink.add(data);
  }

  Future<ProfileModel> userInfo(String phone) async {
    UserModel user = (await cloudFireUser.getUsers(phone)).first;
    List<FollowerModel> dataFollowers = await followerCF.allUser2(phone);
    List<FollowerModel> dataFollowing = await followerCF.allUser1(phone);
    user.followersCount = dataFollowers.length;
    user.followingCount = dataFollowing.length;
    List<LentaModel> lenta = await lentaCF.getMyPublications(phone);
    ProfileModel profile = ProfileModel(
      user: user,
      lenta: lenta,
    );
    return profile;
  }
}

final profileBloc = ProfileBloc();
