import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class AddProductProvider with ChangeNotifier {
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

  Future<void> uploadToFirebaseStorage(String filePath, String id) async {
    String targetPath;
    String folderName = "compressedImages";
    final Directory appDir = await getApplicationDocumentsDirectory();
    final Directory appDirFolder = Directory('${appDir.path}/$folderName/');
    if (await appDirFolder.exists()) {
      targetPath = appDirFolder.path + "$id.jpg";
      notifyListeners();
    } else {
      final Directory newFolder = await appDirFolder.create(recursive: true);
      targetPath = newFolder.path + "$id.jpg";
      notifyListeners();
    }
    File file = File(filePath);
    var compressedFile = await FlutterImageCompress.compressAndGetFile(file.absolute.path, targetPath, quality: 50, minWidth: 400, minHeight: 400);
    print(file.lengthSync());
    print(compressedFile.lengthSync());

    try {
      await FirebaseStorage.instance.ref('uploads/$id').putFile(compressedFile);
      downloadUrl = await FirebaseStorage.instance.ref('uploads/$id').getDownloadURL();
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  void addProduct(CollectionReference products, int id, AddProductProvider cameraProvider, String title, String description, double price, BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("Loading...")));

    uploadToFirebaseStorage(cameraProvider.picturePath, id.toString()).whenComplete(() {
      products.add({
        "id": id.toString(),
        "title": title,
        "imageUrl": cameraProvider.url != null ? cameraProvider.url : "unknown",
        "isFavorite": false,
        "description": description,
        "price": price,
      }).whenComplete(() {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("done!")));
        title = "";
        price = 0.0;
        description = "";
        cameraProvider.picturePath = null;
      });
    });
    notifyListeners();
  }
}
