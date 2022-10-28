import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zet_fire/src/cloud_firestore/comment_cloud_fire.dart';
import 'package:zet_fire/src/model/comment_model.dart';
import 'package:zet_fire/src/model/lenta_model.dart';

class CommentBloc {
  final CommentCloudFire ccf = CommentCloudFire();
  final _fetchComment = PublishSubject<LentaModel>();

  Stream<LentaModel> get getComments => _fetchComment.stream;

  allComments(LentaModel data) async {
    List<CommentModel> comments = await ccf.getSingleLentaComments(data.id);
    data.commentData = comments;
    data.commentCount = comments.length;
    _fetchComment.sink.add(data);
  }

  saveComment(LentaModel data, String comment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    CommentModel commentModel = CommentModel(
      postId: data.id,
      userPhone: prefs.getString("phone_number") ?? "",
      comment: comment,
      time: DateTime.now().millisecondsSinceEpoch,
    );
    await ccf.saveComment(commentModel);
    data.commentCount++;
    data.commentData.add(commentModel);
    _fetchComment.sink.add(data);
  }
}

final commentBloc = CommentBloc();
