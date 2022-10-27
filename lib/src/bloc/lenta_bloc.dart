import 'package:rxdart/rxdart.dart';
import 'package:zet_fire/src/cloud_firestore/comment_cloud_fire.dart';
import 'package:zet_fire/src/cloud_firestore/follower_cloud_fire.dart';
import 'package:zet_fire/src/cloud_firestore/lenta_cloud_fire.dart';
import 'package:zet_fire/src/model/comment_model.dart';
import 'package:zet_fire/src/model/follower_model.dart';
import 'package:zet_fire/src/model/lenta_model.dart';

class LentaBloc {
  final LentaCloudFire lcf = LentaCloudFire();
  final _fetchLenta = PublishSubject<List<LentaModel>>();

  Stream<List<LentaModel>> get getLenta => _fetchLenta.stream;

  allLenta(String phone) async {
    List<LentaModel> lenta = await lcf.getAllPublications();
    List<FollowerModel> followed = await followerCloudFire.allUser1(phone);
    List<CommentModel> comments = await commentCloudFire.getComments();
    List<LentaModel> lateLenta = [];
    if (followed.isEmpty) {
      _fetchLenta.sink.add(lenta);
    } else {
      for (int i = 0; i < lenta.length; i++) {
        for (int j = 0; j < followed.length; j++) {
          if (lenta[i].userPhone == followed[j].user2) {
            lateLenta.add(lenta[i]);
          }
        }
        for (int j = 0; j < comments.length; j++) {
          if (lenta[i].id == comments[j].postId) {
            lenta[i].commentData.add(comments[j]);
          }
        }
      }
      _fetchLenta.sink.add(lateLenta);
    }
  }

  postPublication(LentaModel lentaModel, String phone) async {
    await lcf.postPublication(lentaModel);
    allLenta(phone);
  }
}

final lentaBloc = LentaBloc();
