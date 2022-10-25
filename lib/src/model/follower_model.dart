class FollowerModel {
  String user1;
  String user2;
  String id;

  FollowerModel({
    required this.user1,
    required this.user2,
    this.id = '',
  });

  factory FollowerModel.fromJson(Map<dynamic, dynamic> json) => FollowerModel(
        user1: json['user_1']??'',
        user2: json['user_2']??'',
      );

  Map<String, dynamic> toJson() => {
        'user_1': user1,
        'user_2': user2,
      };
}
