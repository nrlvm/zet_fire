class CommentModel {
  String id;
  String postId;
  String userPhone;
  String comment;

  CommentModel({
    this.id = '',
    required this.postId,
    required this.userPhone,
    required this.comment,
  });

  factory CommentModel.fromJson(Map<dynamic, dynamic> json) => CommentModel(
        postId: json['post_id'],
        userPhone: json['user_phone'],
        comment: json['comment'],
      );

  Map<String, dynamic> toJson() => {
        'post_id': postId,
        'user_phone': userPhone,
        'comment': comment,
      };
}
