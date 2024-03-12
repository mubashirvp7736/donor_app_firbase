import 'dart:io';

import 'package:firebase/controller/donor_provider.dart';
import 'package:firebase/model/donor_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase/controller/add_provider.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Donor"),
      ),
      body:const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AddDonorForm(),
          ],
        ),
      ),
    );
  }
}

class AddDonorForm extends StatefulWidget {
  const AddDonorForm({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddDonorFormState createState() => _AddDonorFormState();
}

class _AddDonorFormState extends State<AddDonorForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final addUserData = Provider.of<AddDonorProvider>(context,listen: false);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: addUserData.nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter name";
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: addUserData.numberController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Number',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter Number";
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.horizontal()),
              labelText: 'Blood Group',
            ),
            value: addUserData.selectedItem,
            items: addUserData.bloodCat.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              addUserData.selectedGroup(newValue!);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter group";
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                add();
                Navigator.pop(context);    }
            },
            child: const Text("Add Donor"),
          ),
        ],
      ),
    );
  }

  add() async {
    final getprv = Provider.of<AddDonorProvider>(context,listen:  false);

    if (getprv.nameController.text.isNotEmpty &&
        getprv.numberController.text.isNotEmpty &&
        getprv.selectedItem != null) {
      final data = DonorModel(
        name: getprv.nameController.text,
        phone: int.parse(getprv.numberController.text),
        group: getprv.selectedItem!,
        image: 'image', 
         );
      await Provider.of<DonorProvider>(context, listen: false).addDonor(data);
    }
  }
}
