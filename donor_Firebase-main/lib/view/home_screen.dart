import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/controller/donor_provider.dart';
import 'package:firebase/view/add_donor.dart';
import 'package:firebase/view/edit_donor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
    HomeScreen({super.key});

  final CollectionReference donor=FirebaseFirestore.instance.collection('donor');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Donors Details'),
        backgroundColor: Colors.red,
      ),
      body: Consumer<DonorProvider>(
        builder: (context, value, child) {
          value.getData();
          return  ListView.builder(
                itemCount: value.list.length,
                itemBuilder: (context, index) {
                   final data = value.list[index];
                   return Card(
                    elevation: 5,
                    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)) ,
                    child: Container(
                      color: Colors.grey.shade600,
                      height:120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           CircleAvatar(
                            radius: 40,
                            child: Text( "${data.group}"),
                            backgroundColor: Colors.red ,
                           ),
                       Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Name :${data.name}",style:const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                             const SizedBox(height: 10,),
                              Text(  "Phone:${data.phone}"),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(onPressed:(){
                          
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateDonor(data: data),)) ;                    
                              }, icon:const Icon(Icons.edit),color: Colors.blue,iconSize:30,),
                              IconButton(onPressed: (){
                             Provider.of<DonorProvider>(context,listen: false).deleteDonor(data.id!);
                              }, icon:const Icon(Icons.delete),color: Colors.red,iconSize: 30,)
                            ],
                          )
                        ],
                      ),
                    ),
                           
                  );
                },
                
                 );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>const AddScreen(),));},
      child:const Icon(Icons.add),),
    );
  }
}