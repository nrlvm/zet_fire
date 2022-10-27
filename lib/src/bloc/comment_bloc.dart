import 'package:rxdart/rxdart.dart';
import 'package:zet_fire/src/cloud_firestore/comment_cloud_fire.dart';
import 'package:zet_fire/src/model/comment_model.dart';

class CommentBloc {
  final CommentCloudFire ccf = CommentCloudFire();
  final _fetchComment = PublishSubject<List<CommentModel>>();

  Stream<List<CommentModel>> get getComments => _fetchComment.stream;

  allComments(String postID) async {
    List<CommentModel> comments = await ccf.getSingleLentaComments(postID);
    _fetchComment.sink.add(comments);
  }
}
final commentBloc = CommentBloc();
