// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wallyapp/style/costants.dart';
import 'package:path/path.dart' as path;

class AddWallpaperScreen extends StatefulWidget {
  const AddWallpaperScreen({Key? key}) : super(key: key);

  @override
  State<AddWallpaperScreen> createState() => _AddWallpaperScreenState();
}

class _AddWallpaperScreenState extends State<AddWallpaperScreen> {
  XFile? _image;

  final storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UploadTask? task;
  bool uploaded = false;
  bool onprogress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                uploadImage();
              },
              child: _image != null
                  ? Image.file(
                      File(_image!.path),
                      fit: BoxFit.cover,
                    )
                  : Image.asset("assets/placeholder.jpg"),
            ),
            Text(
              "Click on image to upload wallpaper",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(kPrimaryColor),
              ),
              onPressed: () {
                uploadToFirebaseStorage();
              },
              child: const Text(
                "Upload to Firebase Storage",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Text(
              uploaded ? "completely uploaded" : "",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              onprogress ? " Uploading" : "",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  uploadImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  File convertToFile(XFile xFile) {
    File imageFile = File(xFile.path);
    return imageFile;
  }

  uploadToFirebaseStorage() async {
    if (_image != null) {
      final imageFile = convertToFile(_image!);
      final String imgPath = path.basename(imageFile.path);
      final user = _auth.currentUser;
      task = storage
          .ref("user uid: ${user!.uid}")
          .child("wallpapers")
          .child(imgPath)
          .putFile(imageFile);
      final snapshot = await task!.whenComplete(() {});
      if (snapshot.state == TaskState.running) {
        uploaded = false;
        onprogress = true;
        setState(() {});
      } else if (snapshot.state == TaskState.success) {
        uploaded = true;
        onprogress = false;
        setState(() {});
      }
    } else {
      print("error");
    }
  }
}
