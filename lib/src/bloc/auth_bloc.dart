import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zet_fire/src/cloud_firestore/user_cloud_fire.dart';
import 'package:zet_fire/src/model/user_model.dart';
import 'package:zet_fire/src/storage/storage_firebase.dart';

class AuthBloc {
  final UsersCloudFire cloudFireUser = UsersCloudFire();

  Future<bool> logIn(String phoneNumber, String password) async {
    bool k = false;
    List<UserModel> data = await cloudFireUser.getUsers(phoneNumber);
    for (int i = 0; i < data.length; i++) {
      if (data[i].password == password) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('user_name', data[i].userName);
        prefs.setString('phone_number', data[i].phone);
        prefs.setString('password', data[i].password);
        prefs.setString('id', data[i].id);
        k = true;
        break;
      }
    }
    return k;
  }

  Future<bool> numberAlreadyUser(String phoneNumber) async {
    List<UserModel> data = await cloudFireUser.getUsers(phoneNumber);
    bool userExist = data.isEmpty ? false : true;
    return userExist;
  }

  Future<String> saveUser(UserModel data) async {
    String id = (await cloudFireUser.saveUser(data)).id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_name', data.userName);
    prefs.setString('phone_number', data.phone);
    prefs.setString('password', data.password);
    prefs.setString('id', id);
    return id;
  }

  deleteUserPhoto(UserModel data) async {
    await storageFirebase.deleteFile(data.userPhoto);
  }

  updateUser(UserModel data) async {
    await cloudFireUser.updateUser(data);
  }

  deleteUser(UserModel data) async {
    await cloudFireUser.deleteUser(data);
  }
}

final authBloc = AuthBloc();
