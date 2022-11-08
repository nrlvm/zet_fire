import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zet_fire/src/model/blocked_content_model.dart';

class BlockContentCloudFire {
  final CollectionReference cr =
      FirebaseFirestore.instance.collection('bloc_content');

  Future<List<BlockedContentModel>> getBlockedContent(String userId) async {
    var data = await cr.where('user_id', isEqualTo: userId).get();
    List<BlockedContentModel> list = [];
    for (int i = 0; i < data.docs.length; i++) {
      BlockedContentModel model = BlockedContentModel.fromJson(
          data.docs[i].data() as Map<String, dynamic>);
      model.id = data.docs[i].id;
      list.add(model);
    }
    return list;
  }

  blockContent(String lentaId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myPhone = prefs.getString('phone_number') ?? '';
    BlockedContentModel model = BlockedContentModel(
      userId: myPhone,
      lentaId: lentaId,
    );
    await cr.add(model.toJson());
  }
}

final blockContentCloudFire = BlockContentCloudFire();
