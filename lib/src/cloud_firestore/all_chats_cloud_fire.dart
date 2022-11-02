import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zet_fire/src/model/chat_model.dart';

class AllChatsCloudFire {
  final CollectionReference cr =
      FirebaseFirestore.instance.collection('all_chats');

  Future<List<ChatModel>> getChats(String key, String phone) async {
    var data = await cr.where(key, isEqualTo: phone).get();
    List<ChatModel> list = [];
    for (int i = 0; i < data.size; i++) {
      ChatModel chatModel = ChatModel.fromJson(
        data.docs[i].data() as Map<String, dynamic>,
      );
      chatModel.id = data.docs[i].id;
      list.add(chatModel);
    }
    return list;
  }

  Future<String> createChat(ChatModel data) async {
    var info = await cr.add(data.toJson());
    return info.id;
  }
}
