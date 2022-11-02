class ChatModel {
  String user1;
  String user2;
  String id;

  ChatModel({
    required this.user1,
    required this.user2,
    this.id = '',
  });

  factory ChatModel.fromJson(Map<dynamic, dynamic> json) => ChatModel(
        user1: json['user_1'] ?? '',
        user2: json['user_2'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'user_1': user1,
        'user_2': user2,
      };
}
