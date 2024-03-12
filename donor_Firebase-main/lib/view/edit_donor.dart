import 'package:firebase/controller/add_provider.dart';
import 'package:firebase/controller/donor_provider.dart';
import 'package:firebase/model/donor_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateDonor extends StatelessWidget {
  final DonorModel data;
   const UpdateDonor({super.key, required this.data});
   @override
 Widget build(BuildContext context) {
    final update=Provider.of<AddDonorProvider>(context,listen: false);
    update.nameController.text=data.name?? '';
   update.numberController.text=data.phone.toString();
    update.selectedItem=data.group;
     final docId=data.id;
    return Scaffold(
      appBar:AppBar(
        title:const Text("Update Donor"),
        backgroundColor: Colors.red,
      ),
     body: SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller:update.nameController,
                decoration:const InputDecoration(border: OutlineInputBorder( ),label:Text('Name')),
              
              ),
              const SizedBox(height: 8,),
              TextFormField(
                controller:update.numberController,
                decoration:const InputDecoration(border: OutlineInputBorder( ),label: Text('Number')),
               
              ),
            const SizedBox(height: 8,),
               DropdownButtonFormField<String>(
                decoration:const InputDecoration(border: OutlineInputBorder
                (borderRadius: BorderRadius.horizontal()),label:Text( 'Bloodgroup')),
                value:update.selectedItem,
                items:update.bloodCat.map((String value) {
                    return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  Provider.of<AddDonorProvider>(context,listen: false).selectedGroup(newValue!);
                },
              ),
             const SizedBox(height: 10,),
             TextButton(onPressed: ()async{
              final getprv = Provider.of<AddDonorProvider>(context,listen:  false);

   
            final data = DonorModel(
        name: getprv.nameController.text,
        phone: int.parse(getprv.numberController.text),
        group: getprv.selectedItem!,
        
      );
       await Provider.of<DonorProvider>(context,listen: false).updateDonor(docId, data);
       // ignore: use_build_context_synchronously
       Navigator.pop(context);
           
             
             }, child:const Text("UPDATE"))
            ],
          ),
        ),
      ),
    );
    
  
  }
  
}