import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GetStorageScreen extends StatefulWidget {
  const GetStorageScreen({super.key});

  @override
  State<GetStorageScreen> createState() => _GetStorageScreenState();
}

class _GetStorageScreenState extends State<GetStorageScreen> {
 
  File? selectImage; 
  final ImagePicker imagePicker = ImagePicker();
  
  Future<void> getImage(ImageSource source)async{
    final XFile? image = await imagePicker.pickImage(source: source);
    if(selectImage != null){
      setState(() {
        selectImage = File(image!.path);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         if(selectImage != null)
           CircleAvatar(
             backgroundImage:  FileImage(selectImage!),
             radius: 50,
           ),
 
          ElevatedButton(
            onPressed: () {
            getImage(ImageSource.camera);
            },
            child: const Text('Gallery'),
          ),

          ElevatedButton(
            onPressed: () {
               getImage(ImageSource.gallery);
            },
            child: const Text('Camera'),
          ),
        ],
      ),
    );
  }
}