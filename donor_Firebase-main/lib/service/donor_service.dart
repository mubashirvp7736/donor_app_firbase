
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/model/donor_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
class DonorService{

  final FirebaseFirestore firestore=FirebaseFirestore.instance;
 late final CollectionReference<DonorModel>donorRef;
 final FirebaseStorage storage=FirebaseStorage.instance;

 DonorService(){
  donorRef=firestore.collection('donor').withConverter(fromFirestore:
   (snapshot, options) => DonorModel.fromJson(snapshot.data()!,snapshot.id),
    toFirestore: (value, options) => value.toJson(),);
 }
   Future<List<DonorModel>> getAllProducts() async {
    final snapshot =
        await donorRef.get();
        
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}