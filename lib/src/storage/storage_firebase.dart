import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageFirebase {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> upload(String folder, XFile photo) async {
    final path = '$folder/${photo.name}';
    final file = File(photo.path);

    final ref = FirebaseStorage.instance.ref().child(path);

    final snapshot = await ref.putFile(file).whenComplete(() => null);
    String photoUrl = await snapshot.ref.getDownloadURL();

    return photoUrl;
  }

  deleteFile(String url) async {
    Reference ref = FirebaseStorage.instance.refFromURL(url);
    await ref.delete();
  }
}

final storageFirebase = StorageFirebase();
