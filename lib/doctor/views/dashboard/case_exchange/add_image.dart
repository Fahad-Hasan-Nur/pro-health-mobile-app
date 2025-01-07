// ignore_for_file: unused_field, unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:pro_health/base/utils/constants.dart';

// import 'package:firebase_storage/firebase_storage.dart' ;
class AddImagePage extends StatefulWidget {
  const AddImagePage({Key? key}) : super(key: key);

  @override
  _AddImagePageState createState() => _AddImagePageState();
}

class _AddImagePageState extends State<AddImagePage> {
  // Collection
  // CollectionReference
  late firebase_storage.Reference ref;

  List<Map<String, dynamic>> imgPaths = [];
  late CollectionReference imgRef;

  List<File> _image = [];
  final picker = ImagePicker();

  List<String> _imageDataList = [];

  bool uploading = false;
  double val = 0;

  @override
  void initState() {
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('imageURLs');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Image'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                uploading = true;
              });
              uploadFile().whenComplete(() => Navigator.of(context).pop());
            },
            child: Text(
              'upload',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: _image.length + 1,
            itemBuilder: (BuildContext context, int index) {
              return index == 0
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.grey[200],
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () => !uploading ? chooseImage() : null,
                          icon: Icon(Icons.add),
                        ),
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(_image[index - 1]),
                            fit: BoxFit.cover),
                      ),
                    );
            },
          ),
          uploading
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: Text(
                          'Uploading...',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      CircularProgressIndicator(
                        value: val,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  chooseImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile!.path));
    });
    if (pickedFile!.path == null) return retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  Future uploadFile() async {
    for (var item in _image) {
      String? image = item == null ? null : getStringImage(item);
      _imageDataList.add(image ?? '');
    }
  }

  // Future uploadFile() async {
  //   int i = 1;

  //   for (var img in _image) {
  //     setState(() {
  //       val = i / _image.length;
  //     });
  //     ref = firebase_storage.FirebaseStorage.instance
  //         .ref()
  //         .child('images/${p.basename(img.path)}');
  //     await ref.putFile(img).whenComplete(() async {
  //       await ref.getDownloadURL().then((value) {
  //         imgRef.add({"url": value});
  //         imgPaths.add({"url": value});
  //         i++;
  //       });
  //     });
  //   }

  // }
}
