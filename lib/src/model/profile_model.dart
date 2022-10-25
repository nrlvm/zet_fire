import 'package:zet_fire/src/model/lenta_model.dart';
import 'package:zet_fire/src/model/user_model.dart';

class ProfileModel {
  UserModel user;
  List<LentaModel> lenta;
  bool isFollowed;
  String id;

  ProfileModel({
    required this.user,
    required this.lenta,
    this.isFollowed = false,
    this.id = '',
  });

  factory ProfileModel.fromJson(Map<dynamic, dynamic> json) => ProfileModel(
        user: json['user'] ?? UserModel.fromJson({}),
        lenta: json['lenta'] ?? <LentaModel>[],
      );
}
