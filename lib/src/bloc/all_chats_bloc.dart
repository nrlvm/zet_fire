import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zet_fire/src/cloud_firestore/all_chats_cloud_fire.dart';
import 'package:zet_fire/src/model/chat_model.dart';

class AllChatsBloc {
  final AllChatsCloudFire allChatsCloudFire = AllChatsCloudFire();

  final _fetchChats = PublishSubject<List<ChatModel>>();

  Stream<List<ChatModel>> get getChats => _fetchChats.stream;

  allChats(String phone) async {
    List<ChatModel> chat = await allChatsCloudFire.getChats('user_1', phone);
    chat.addAll(await allChatsCloudFire.getChats('user_2', phone));
    _fetchChats.sink.add(chat);
  }

  Future<ChatModel> chatExists(String user1, String myPhone) async {
    List<ChatModel> chats = await allChatsCloudFire.getChats('user_1', user1);
    for (int i = 0; i < chats.length; i++) {
      if (chats[i].user2 == myPhone) {
        return chats[i];
      }
    }
    List<ChatModel> info = await allChatsCloudFire.getChats('user_2', user1);
    for (int i = 0; i < info.length; i++) {
      if (info[i].user1 == myPhone) {
        return info[i];
      }
    }
    return ChatModel.fromJson({});
  }

  Future<String> createChat(String userPhone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myPhone = prefs.getString('phone_number') ?? '';
    if (myPhone != '') {
      ChatModel chatModel = ChatModel(user1: myPhone, user2: userPhone);
      String info = await allChatsCloudFire.createChat(chatModel);
      return info;
    } else {
      return '';
    }
  }

  updateChat(String message, ChatModel chat) async {
    chat.lastMessage = message;
    await allChatsCloudFire.updateChatInfo(chat);
  }
}

final allChatsBloc = AllChatsBloc();
