import 'package:rxdart/rxdart.dart';
import 'package:zet_fire/src/cloud_firestore/lenta_cloud_fire.dart';
import 'package:zet_fire/src/model/lenta_model.dart';

class LentaBloc {
  final LentaCloudFire lcf = LentaCloudFire();
  final _fetchLenta = PublishSubject<List<LentaModel>>();

  Stream<List<LentaModel>> get getLenta => _fetchLenta.stream;

  allLenta() async {
    List<LentaModel> lenta = await lcf.getAllPublications();
    List<LentaModel> data = [];
    for(int i = lenta.length -1; i >=0; i --){
      data.add(lenta[i]);
    }
    _fetchLenta.sink.add(data);
  }

  Future<List<LentaModel>> profileLenta(String phone) async {
    List<LentaModel> data = await lcf.getAllPublications();
    List<LentaModel> profileLenta = [];
    for (int i = 0; i < data.length; i++) {
      if (data[i].userPhone == phone) {
        profileLenta.add(data[i]);
      }
    }
    return profileLenta;
  }

  postPublication(LentaModel lentaModel) async {
    await lcf.postPublication(lentaModel);
    allLenta();
  }
}

final lentaBloc = LentaBloc();
