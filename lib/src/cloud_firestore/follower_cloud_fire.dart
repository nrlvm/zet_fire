import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FollowerCloudFire {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('follower');


}
