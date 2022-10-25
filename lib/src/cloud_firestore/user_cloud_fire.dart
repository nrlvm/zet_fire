import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zet_fire/src/model/user_model.dart';

class UsersCloudFire {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('users');

  Future<DocumentReference> saveUser(UserModel data) {
    return _collection.add(data.toJson());
  }

  Future<List<UserModel>> getUsers(String phone) async {
    var data = await _collection.where('phone', isEqualTo: phone).get();
    List<UserModel> users = [];
    for (int i = 0; i < data.docs.length; i++) {
      UserModel userModel =
          UserModel.fromJson(data.docs[i].data() as Map<String, dynamic>);
      userModel.id = data.docs[i].id;
      users.add(userModel);
    }
    return users;
  }

  updateUser(UserModel data) async {
    await _collection.doc(data.id).update(data.toJson());
  }

  deleteUser(UserModel data) async {
    await _collection.doc(data.id).delete();
  }
}
