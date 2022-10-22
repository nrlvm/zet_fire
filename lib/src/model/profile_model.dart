import 'package:zet_fire/src/model/lenta_model.dart';
import 'package:zet_fire/src/model/user_model.dart';

class ProfileModel {
  UserModel user;
  List<LentaModel> lenta;

  ProfileModel({
    required this.user,
    required this.lenta,
  });
}
