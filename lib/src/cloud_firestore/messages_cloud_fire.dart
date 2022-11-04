import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zet_fire/src/model/message_model.dart';

class MessagesCloudFire {
  final CollectionReference cr =
      FirebaseFirestore.instance.collection('messages');

  Future<List<MessageModel>> getMessages(String chatId) async {
    var data = await cr.where('chat_id', isEqualTo: chatId).get();
    List<MessageModel> messages = [];
    for (int i = 0; i < data.size; i++) {
      MessageModel messageModel =
          MessageModel.fromJson(data.docs[i].data() as Map<String, dynamic>);
      messageModel.id = data.docs[i].id;
      messages.add(messageModel);
    }
    messages.sort((a,b)=> b.time.compareTo(a.time));
    return messages;
  }

  createMessage(MessageModel data) async {
    await cr.add(data.toJson());
  }
}
