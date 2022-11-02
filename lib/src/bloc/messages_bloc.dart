import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zet_fire/src/bloc/all_chats_bloc.dart';
import 'package:zet_fire/src/cloud_firestore/messages_cloud_fire.dart';
import 'package:zet_fire/src/model/chat_model.dart';
import 'package:zet_fire/src/model/message_model.dart';

class MessagesBloc {
  final MessagesCloudFire mcf = MessagesCloudFire();

  final _fetchMessages = PublishSubject<List<MessageModel>>();

  Stream<List<MessageModel>> get getMessages => _fetchMessages.stream;

  allMessages(String userPhone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myPhone = prefs.getString('phone_number') ?? '';
    ChatModel model = await allChatsBloc.chatExists(myPhone, userPhone);
    if (model.id != "") {
      List<MessageModel> messages = await mcf.getMessages(model.id);
      for (int i = 0; i < messages.length; i++) {
        messages[i].chatId == model.id;
        if (messages[i].userId == myPhone) {
          messages[i].fromMe = true;
        }
      }
      _fetchMessages.sink.add(messages);
    }
  }

  createMessage(String text, String chatId, String userPhone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myPhone = prefs.getString('phone_number') ?? '';
    MessageModel messageModel = MessageModel(
      userId: myPhone,
      text: text,
      time: DateTime.now().millisecondsSinceEpoch,
      chatId: chatId,
    );
    await mcf.createMessage(messageModel);
    allMessages(userPhone);
  }
}

final messagesBloc = MessagesBloc();
