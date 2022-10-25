import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zet_fire/src/model/follower_model.dart';

class FollowerCloudFire {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('follower');

  Future<List<FollowerModel>> allUser1(String number) async {
    var data = await _collection.where("user_1", isEqualTo: number).get();
    List<FollowerModel> followers = [];
    for (int i = 0; i < data.docs.length; i++) {
      FollowerModel followerModel = FollowerModel.fromJson(
        data.docs[i].data() as Map<String, dynamic>,
      );
      followerModel.id = data.docs[i].id;
      followers.add(followerModel);
    }
    return followers;
  }

  Future<List<FollowerModel>> allUser2(String number) async {
    var data = await _collection.where("user_2", isEqualTo: number).get();
    List<FollowerModel> followers = [];
    for (int i = 0; i < data.docs.length; i++) {
      FollowerModel followerModel = FollowerModel.fromJson(
        data.docs[i].data() as Map<String, dynamic>,
      );
      followerModel.id = data.docs[i].id;
      followers.add(followerModel);
    }
    return followers;
  }

  Future<DocumentReference> follow(FollowerModel data) async {
    return _collection.add(data.toJson());
  }

  unfollow(String id) async {
    await _collection.doc(id).delete();
  }
}

final followerCloudFire = FollowerCloudFire();
