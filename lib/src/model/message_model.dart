class MessageInfoModel {
  List<MessageModel> data;
  String chatId;

  MessageInfoModel({
    required this.data,
    required this.chatId,
  });
}

class MessageModel {
  String userId;
  String text;
  String chatId;
  String id;
  int time;
  bool fromMe;

  MessageModel({
    required this.userId,
    required this.text,
    required this.time,
    required this.chatId,
    this.id = '',
    this.fromMe = false,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        userId: json['user_id'] ?? '',
        text: json['text'] ?? '',
        time: json['time'] ?? 0,
        chatId: json['chat_id'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'text': text,
        'chat_id': chatId,
        'time': time,
      };
}
