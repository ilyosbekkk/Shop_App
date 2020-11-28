import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class CameraProvider with ChangeNotifier {
  String picturePath;
  String downloadUrl;

  get path {
    return picturePath;
  }

  get url {
    return downloadUrl;
  }

  Future<void> selectImage(ImageSource imageSource) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: imageSource);
    if (pickedFile != null) {
      picturePath = pickedFile.path;
      print(picturePath);

      notifyListeners();
    } else {
      print("Error occured");
    }
  }

  Future<void> uploadToFireStore(String filePath,  String id) async {
    String  targetPath = "/data/user/0/com.example.shop_app/cache2/$id.jpg";
    File file = File(filePath);
    var compressedFile =await
         FlutterImageCompress.compressAndGetFile(file.absolute.path, targetPath, quality: 50, minWidth: 400, minHeight: 400);
    print(file.lengthSync());
    print(compressedFile.lengthSync());

    try {
      await FirebaseStorage.instance.ref('uploads/$id').putFile(compressedFile);
      downloadUrl = await FirebaseStorage.instance
          .ref('uploads/$id')
          .getDownloadURL();
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}
