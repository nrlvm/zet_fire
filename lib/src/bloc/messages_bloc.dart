import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zet_fire/src/bloc/all_chats_bloc.dart';
import 'package:zet_fire/src/cloud_firestore/messages_cloud_fire.dart';
import 'package:zet_fire/src/model/chat_model.dart';
import 'package:zet_fire/src/model/message_model.dart';

class MessagesBloc {
  final MessagesCloudFire mcf = MessagesCloudFire();

  final _fetchMessages = PublishSubject<MessageInfoModel>();

  Stream<MessageInfoModel> get getMessages => _fetchMessages.stream;

  List<MessageModel> data = [];

  allMessages(String userPhone, String chatId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myPhone = prefs.getString('phone_number') ?? '';
    ChatModel model = ChatModel.fromJson({});
    if (chatId == "") {
      model = await allChatsBloc.chatExists(myPhone, userPhone);
    } else {
      model.id = chatId;
    }
    if (model.id != "") {
      List<MessageModel> messages = await mcf.getMessages(model.id);
      for (int i = 0; i < messages.length; i++) {
        if (messages[i].userId == myPhone) {
          messages[i].fromMe = true;
        }
      }
      data = messages;
      _fetchMessages.sink.add(
        MessageInfoModel(
          chatId: model.id,
          data: data,
        ),
      );
    } else {
      _fetchMessages.sink.add(
        MessageInfoModel(
          chatId: "",
          data: [],
        ),
      );
    }
  }

  createMessage(String text, String chatId, String userPhone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myPhone = prefs.getString('phone_number') ?? '';
    if (chatId == "") {
      chatId = await allChatsBloc.createChat(userPhone);
    }
    MessageModel messageModel = MessageModel(
      userId: myPhone,
      text: text,
      fromMe: true,
      time: DateTime.now().millisecondsSinceEpoch,
      chatId: chatId,
    );
    await mcf.createMessage(messageModel);
    data.insert(0, messageModel);
    _fetchMessages.sink.add(
      MessageInfoModel(
        chatId: chatId,
        data: data,
      ),
    );
    ChatModel chat = await allChatsBloc.chatExists(userPhone, myPhone);
    allChatsBloc.updateChat(messageModel.text, chat);
  }
}

final messagesBloc = MessagesBloc();
