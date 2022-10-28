import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zet_fire/src/model/like_model.dart';

class LikeCloudFire {
  final CollectionReference cr = FirebaseFirestore.instance.collection('like');

  Future<List<LikeModel>> getLikes() async {
    var data = await cr.get();
    List<LikeModel> likes = [];
    for (int i = 0; i < data.docs.length; i++) {
      LikeModel model = LikeModel.fromJson(
        data.docs[i].data() as Map<String, dynamic>,
      );
      model.id = data.docs[i].id;
      likes.add(model);
    }
    return likes;
  }

  Future<String> saveLike(LikeModel data) async {
    var info = await cr.add(data.toJson());
    return info.id;
  }

  Future<void> deleteLike(String id) async {
    await cr.doc(id).delete();
  }
}

final likeCloudFire = LikeCloudFire();
