import 'package:firebase/model/donor_model.dart';
import 'package:firebase/service/donor_service.dart';
import 'package:flutter/material.dart';

class DonorProvider extends ChangeNotifier{
  DonorService donorService =DonorService();
List <DonorModel> list =[];
  getData()async{
  list=  await donorService.getAllProducts();
  notifyListeners();
  }
  addDonor(DonorModel data)async{
    await donorService.donorRef.add(data);
    getData();
  }
  updateDonor(id,DonorModel data){
    donorService.donorRef.doc(id).update(data.toJson());
    getData();
  }
  deleteDonor(id){
    donorService.donorRef.doc(id).delete();
    getData();
  }
}