import 'package:zet_fire/src/model/comment_model.dart';

class LentaModel {
  String url;
  String id;
  String caption;
  String userPhone;
  String contentType;
  int time;
  int commentCount;
  int likeCount;
  String likeId;
  List<CommentModel> commentData = [];

  LentaModel({
    this.id = '',
    this.likeId = '',
    this.commentCount = 0,
    this.likeCount = 0,
    required this.contentType,
    required this.caption,
    required this.url,
    required this.userPhone,
    required this.time,
  });

  factory LentaModel.fromJson(Map<dynamic, dynamic> json) => LentaModel(
        url: json['url'] ?? "",
        userPhone: json['phone'] ?? "",
        time: json['time'] ?? 0,
        caption: json['caption'] ?? "",
        contentType: json['content_type'] ?? "photo",
      );

  Map<String, dynamic> toJson() => {
        'url': url,
        'phone': userPhone,
        'time': time,
        'caption': caption,
        'content_type': contentType,
      };
}

/// contentType either 'photo' or 'video'