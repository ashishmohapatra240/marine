import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddFishPage extends StatefulWidget {
  @override
  _AddFishPageState createState() => _AddFishPageState();
}

class _AddFishPageState extends State<AddFishPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fishNameController = TextEditingController();
  final TextEditingController _ratePerKgController = TextEditingController();
  final TextEditingController _availableTimeController =
      TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  // Future uploadImage() async {
  //   if (_image != null) {
  //     Reference storageReference =
  //         FirebaseStorage.instance.ref().child('fishes/${DateTime.now()}.jpg');
  //     UploadTask uploadTask = storageReference.putFile(_image!);
  //     await uploadTask;
  //     String fileURL = await storageReference.getDownloadURL();
  //     _addFishDetails(fileURL);
  //   } else {
  //     _addFishDetails('');
  //   }
  // }

  void _addFishDetails() {
    FirebaseFirestore.instance.collection('fishes').add({
      'fishName': _fishNameController.text,
      'ratePerKg': int.parse(_ratePerKgController.text),
      'availableTime': _availableTimeController.text,
      'location': _locationController.text,
      // 'imageURL': fileURL,
    });
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Fish Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _image != null
                    ? Image.file(
                        _image!,
                        height: 200.0,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 200.0,
                        color: Colors.grey[200],
                      ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  child: Text('Choose Image'),
                  onPressed: getImage,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _fishNameController,
                  decoration: InputDecoration(
                    labelText: 'Fish Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter fish name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _ratePerKgController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Rate per KG',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter rate per KG';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _availableTimeController,
                  decoration: InputDecoration(
                    labelText: 'Available Time',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter available time';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    labelText: 'Location',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter location';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  child: Text('Save'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // uploadImage();
                      _addFishDetails();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
