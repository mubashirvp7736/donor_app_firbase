
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/service/donor_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class AddDonorProvider extends ChangeNotifier{

  final nameController=TextEditingController();
  final numberController=TextEditingController();
  File? picked;
  String? selectedItem;
  List<String> bloodCat=["A+","B+","AB-","O+","AB+","O-"];
   final CollectionReference donor=FirebaseFirestore.instance.collection('donor');
   DonorService serviceMode=DonorService();

  File? selectedImage;
  ImagePicker imagePicker = ImagePicker();

  void setImage(ImageSource source) async {
    final pickedImage = await imagePicker.pickImage(source: source);

    selectedImage = pickedImage != null ? File(pickedImage.path) : null;
    notifyListeners();
  }

  void selectedGroup(String newValue){
   
   selectedItem = newValue;
    notifyListeners();
  
      }
       void addDonor(){
   final addData={
    'name':nameController.text,
    "number":numberController.text,
    "group":selectedItem
   };
    donor.add(addData);
   }
   
  
  void delete(String id)async{
    await serviceMode.donorRef.doc(id).delete();
    notifyListeners();
  }
}