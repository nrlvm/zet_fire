class LikeModel {
  String id;
  String postId;
  String userPhone;
  int time;

  LikeModel({
    this.id = '',
    required this.postId,
    required this.userPhone,
    required this.time,
  });

  factory LikeModel.fromJson(Map<String, dynamic> json) => LikeModel(
        postId: json['post_id']??'',
        userPhone: json['user_phone']??'',
        time: json['time']??0,
      );

  Map<String, dynamic> toJson() => {
        'post_id': postId,
        'user_phone': userPhone,
        'time': time,
      };
}
