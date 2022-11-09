import 'package:rxdart/rxdart.dart';
import 'package:zet_fire/src/cloud_firestore/block_lenta_cloud_fire.dart';
import 'package:zet_fire/src/cloud_firestore/comment_cloud_fire.dart';
import 'package:zet_fire/src/cloud_firestore/follower_cloud_fire.dart';
import 'package:zet_fire/src/cloud_firestore/lenta_cloud_fire.dart';
import 'package:zet_fire/src/cloud_firestore/like_cloud_fire.dart';
import 'package:zet_fire/src/model/blocked_content_model.dart';
import 'package:zet_fire/src/model/comment_model.dart';
import 'package:zet_fire/src/model/follower_model.dart';
import 'package:zet_fire/src/model/lenta_model.dart';
import 'package:zet_fire/src/model/like_model.dart';

class LentaBloc {
  final LentaCloudFire lcf = LentaCloudFire();
  final _fetchLenta = PublishSubject<List<LentaModel>>();

  Stream<List<LentaModel>> get getLenta => _fetchLenta.stream;
  List<LentaModel> data = [];

  allLenta(String phone) async {
    List<LentaModel> lenta = await lcf.getAllPublications();
    List<FollowerModel> followed = await followerCloudFire.allUser1(phone);
    List<CommentModel> comments = await commentCloudFire.getComments();
    List<LikeModel> allLikes = await likeCloudFire.getLikes();
    List<BlockedContentModel> blocked =
        await blockContentCloudFire.getBlockedContent(phone);
    List<LentaModel> lateLenta = [];
    for (int i = 0; i < lenta.length; i++) {
      for (int k = 0; k < comments.length; k++) {
        if (lenta[i].id == comments[k].postId) {
          lenta[i].commentData.add(comments[k]);
        }
      }
      for (int l = 0; l < allLikes.length; l++) {
        if (lenta[i].id == allLikes[l].postId) {
          lenta[i].likeCount++;
          if (allLikes[l].userPhone == phone) {
            lenta[i].likeId = allLikes[l].id;
          }
        }
      }
      for (int j = 0; j < blocked.length; j++) {
        if (lenta[i].id == blocked[j].lentaId) {
          lenta.remove(lenta[i]);
        }
      }
    }
    if (followed.isEmpty) {
      data = lenta;
      _fetchLenta.sink.add(data);
    } else {
      for (int i = 0; i < lenta.length; i++) {
        for (int j = 0; j < followed.length; j++) {
          if (lenta[i].userPhone == followed[j].user2) {
            lateLenta.add(lenta[i]);
          }
        }
      }
      data = lateLenta;
      _fetchLenta.sink.add(data);
    }
  }

  updateLenta(List<LentaModel> lenta, int index) async {
    lenta.removeAt(index);
    _fetchLenta.sink.add(lenta);
  }

  updateCount(String id) {
    for (int i = 0; i < data.length; i++) {
      if (data[i].id == id) {
        data[i].commentCount++;
        break;
      }
    }
    _fetchLenta.sink.add(data);
  }

  postPublication(LentaModel lentaModel, String phone) async {
    await lcf.postPublication(lentaModel);
    allLenta(phone);
  }
}

final lentaBloc = LentaBloc();
