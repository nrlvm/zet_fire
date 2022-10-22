import 'package:rxdart/rxdart.dart';
import 'package:zet_fire/src/bloc/lenta_bloc.dart';
import 'package:zet_fire/src/bloc/user_bloc.dart';
import 'package:zet_fire/src/model/profile_model.dart';

class ProfileBloc{
  final _fetchProfile = PublishSubject<ProfileModel>();

  Stream<ProfileModel> get getProfile => _fetchProfile.stream;

  allProfile(String phone)async{
    var user = await userBloc.getUserInfo(phone);
    var lenta = await lentaBloc.profileLenta(phone);
    ProfileModel profile = ProfileModel(user: user, lenta: lenta);
    _fetchProfile.sink.add(profile);
  }

}
final profileBloc = ProfileBloc();