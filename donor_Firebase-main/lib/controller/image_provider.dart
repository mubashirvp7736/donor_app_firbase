import 'package:firebase/service/donor_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImageProv extends ChangeNotifier{
   DonorService firebaseService = DonorService();
  String uniquename = DateTime.now().microsecondsSinceEpoch.toString();
  String downloadurl = '';

  imageAdder(image) async {
    Reference folder = firebaseService.storage.ref().child('images');
    Reference images = folder.child("$uniquename.jpg");
    try {
      await images.putFile(image);
      downloadurl = await images.getDownloadURL();
      notifyListeners();
      print(downloadurl);
    } catch (e) {
      throw Exception(e);
    }
  }

}