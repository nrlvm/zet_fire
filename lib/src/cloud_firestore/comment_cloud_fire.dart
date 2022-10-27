import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zet_fire/src/model/comment_model.dart';

class CommentCloudFire {
  final CollectionReference cr =
      FirebaseFirestore.instance.collection('comments');

  Future<List<CommentModel>> getComments() async {
    var data = await cr.get();
    List<CommentModel> comments = [];
    for (int i = 0; i < data.docs.length; i++) {
      CommentModel model =
          CommentModel.fromJson(data.docs[i].data() as Map<String, dynamic>);
      model.id = data.docs[i].id;
      comments.add(model);
    }
    return comments;
  }

  Future<List<CommentModel>> getSingleLentaComments(String id) async {
    var data = await cr.where('post_id', isEqualTo: id).get();
    List<CommentModel> comments = [];
    for (int i = 0; i < data.docs.length; i++) {
      CommentModel model =
          CommentModel.fromJson(data.docs[i].data() as Map<String, dynamic>);
      model.id = data.docs[i].id;
      comments.add(model);
    }
    return comments;
  }
}

final commentCloudFire = CommentCloudFire();
