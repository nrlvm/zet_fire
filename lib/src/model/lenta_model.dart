import 'package:zet_fire/src/model/comment_model.dart';

class LentaModel {
  String url;
  String id;
  String caption;
  String userPhone;
  int time;
  int commentCount;
  int likeCount;
  String likeId;
  List<CommentModel> commentData = [];

  LentaModel({
    this.id = '',
    this.likeId = '',
    required this.caption,
    required this.url,
    required this.userPhone,
    required this.time,
    this.commentCount = 0,
    this.likeCount = 0,
  });

  factory LentaModel.fromJson(Map<dynamic, dynamic> json) => LentaModel(
        url: json['url'] ?? "",
        userPhone: json['phone'] ?? "",
        time: json['time'] ?? 0,
        caption: json['caption'] ?? "",
      );

  Map<String, dynamic> toJson() => {
        'url': url,
        'phone': userPhone,
        'time': time,
        'caption': caption,
      };
}
