class LentaModel {
  String url;
  String id;
  String caption;
  String userPhone;
  int time;
  int commentCount;
  int likeCount;

  LentaModel({
    this.id = '',
    required this.caption,
    required this.url,
    required this.userPhone,
    required this.time,
    this.commentCount = 0,
    this.likeCount = 0,
  });

  factory LentaModel.fromJson(Map<dynamic, dynamic> json) => LentaModel(
        url: json['url'],
        userPhone: json['phone'],
        time: json['time'],
        commentCount: json['comment_count'],
        likeCount: json['like_count'],
        caption: json['caption'],
      );

  Map<String, dynamic> toJson() => {
        'url': url,
        'phone': userPhone,
        'time': time,
        'comment_count': commentCount,
        'like_count': likeCount,
        'caption': caption,
      };
}
