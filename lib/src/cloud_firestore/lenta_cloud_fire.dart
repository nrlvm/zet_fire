import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zet_fire/src/model/lenta_model.dart';

class LentaCloudFire {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('lenta');

  Future<DocumentReference> postPublication(LentaModel data) {
    return _collection.add(data.toJson());
  }

  Future<List<LentaModel>> getAllPublications() async {
    var data = await _collection.orderBy('time', descending: true).get();
    List<LentaModel> lentaList = [];
    for (int i = 0; i < data.docs.length; i++) {
      LentaModel lenta = LentaModel.fromJson(
        data.docs[i].data() as Map<String, dynamic>,
      );
      lenta.id = data.docs[i].id;
      lentaList.add(lenta);
    }
    return lentaList;
  }

  Future<List<LentaModel>> getMyPublications(String number) async {
    var data = await _collection.where("phone", isEqualTo: number).get();
    List<LentaModel> lentaList = [];
    for (int i = 0; i < data.docs.length; i++) {
      LentaModel lenta =
          LentaModel.fromJson(data.docs[i].data() as Map<String, dynamic>);
      lenta.id = data.docs[i].id;
      lentaList.add(lenta);
    }
    return lentaList;
  }
}

final lentaCloudFire = LentaCloudFire();
