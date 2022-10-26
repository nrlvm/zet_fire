import 'package:rxdart/rxdart.dart';
import 'package:zet_fire/src/cloud_firestore/lenta_cloud_fire.dart';
import 'package:zet_fire/src/model/lenta_model.dart';

class ExploreBloc {
  final _fetchExplore = PublishSubject<List<LentaModel>>();

  Stream<List<LentaModel>> get getExploreLenta => _fetchExplore.stream;

  allExploreLenta() async {
    List<LentaModel> lenta = await lentaCloudFire.getAllPublications();
    _fetchExplore.sink.add(lenta);
  }
}

final exploreBloc = ExploreBloc();
