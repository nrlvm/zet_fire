class ChatModel {
  String user1;
  String user2;
  String id;
  String lastMessage;
  int userCount1;
  int userCount2;

  ChatModel({
    required this.user1,
    required this.user2,
    this.id = '',
    this.lastMessage = '',
    this.userCount1 = 0,
    this.userCount2 = 0,
  });

  factory ChatModel.fromJson(Map<dynamic, dynamic> json) => ChatModel(
        user1: json['user_1'] ?? '',
        user2: json['user_2'] ?? '',
        lastMessage: json['last_message'] ?? '',
        userCount1: json['user_count_1'] ?? 0,
        userCount2: json['user_count_2'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'user_1': user1,
        'user_2': user2,
        'last_message': lastMessage,
        'user_count_1': userCount1,
        'user_count_2': userCount2,
      };
}
