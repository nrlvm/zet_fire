class CommentModel {
  String id;
  String postId;
  String userPhone;
  String comment;
  int time;

  CommentModel({
    this.id = '',
    required this.postId,
    required this.userPhone,
    required this.comment,
    required this.time,
  });

  factory CommentModel.fromJson(Map<dynamic, dynamic> json) => CommentModel(
        postId: json['post_id'] ?? "",
        userPhone: json['user_phone'] ?? "",
        comment: json['comment'] ?? "",
        time: json['time'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'post_id': postId,
        'user_phone': userPhone,
        'comment': comment,
        'time': time,
      };
}
