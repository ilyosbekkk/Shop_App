import 'dart:io';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/camera_provider.dart';
import 'package:shop_app/providers/products_provider.dart';

class FormWidget extends StatefulWidget {
  final formKey;

  const FormWidget({this.formKey});

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  bool openCameraOptions = false;
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();

  CollectionReference products =
  FirebaseFirestore.instance.collection('products');
  List<CameraDescription> cameras;
  CameraDescription firstCamera;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context, listen: false);
    final cameraProvider = Provider.of<CameraProvider>(context);
    /*  if (cameraProvider.picturePath != null) {
      cameraProvider
          .uploadToFireStore(cameraProvider.picturePath)
          .then((value) => print("loading..."))
          .whenComplete(() => print("done"));
    }*/
    return SingleChildScrollView(
      child: Form(
        key: widget.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  "Enter your product Info",
                  style: TextStyle(fontSize: 30),
                )),
            editText("title", "Please, enter text!", title),
            editText("price", "Please, enter text!", price),
            editText("description", "Please, enter text!", description),
            selectImage(),
            if (openCameraOptions) imageButtons(cameraProvider),
            if (cameraProvider.picturePath != null)
              Container(
                margin: EdgeInsets.only(top: 15),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()),
                child: Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: Image.file(File(cameraProvider.picturePath)),
                    ),
                    Positioned(
                        bottom: 70,
                        left: 53,
                        child: IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: Colors.red,
                            ),
                            onPressed: null))
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                color: Colors.green,
                textColor: Colors.white,
                onPressed: () {
                  if (widget.formKey.currentState.validate()) {
                    addProduct(productsData.items.length, cameraProvider);
                  }
                },
                child: Text('Add a product'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget editText(String fieldName, String errorMessage,
      TextEditingController text) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextFormField(
        controller: text,
        decoration:
        InputDecoration(labelText: fieldName, border: OutlineInputBorder()),
        validator: (value) {
          if (value.isEmpty) {
            return errorMessage;
          }
          return null;
        },
      ),
    );
  }

  Widget selectImage() {
    return Card(
      child: ListTile(
        title: Text("Select image"),
        trailing: IconButton(
          icon: !openCameraOptions
              ? Icon(Icons.expand_more)
              : Icon(
            Icons.expand_less,
          ),
          onPressed: () {
            setState(() {
              openCameraOptions = !openCameraOptions;
            });
          },
        ),
      ),
    );
  }

  Widget imageButtons(CameraProvider cameraProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {
            cameraProvider.selectImage(ImageSource.gallery);
          },
          icon: Icon(
            Icons.perm_media,
            color: Colors.blue,
            size: 50,
          ),
        ),
        IconButton(
            onPressed: () {
              cameraProvider.selectImage(ImageSource.camera);
            },
            icon: Icon(
              Icons.camera_alt,
              color: Colors.blue,
              size: 50,
            )),
      ],
    );
  }

  Future<void> addProduct(int id, CameraProvider cameraProvider) {
    cameraProvider
        .uploadToFireStore(cameraProvider.picturePath, id.toString())
        .whenComplete(() {
      products.add({
        "id": id.toString(),
        "title": title.text,
        "imageUrl": cameraProvider.url != null ? cameraProvider.url : "unknown",
        "isFavorite": false,
        "description": description.text,
        "price": double.parse(price.text)
      }).whenComplete(() {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("done!")));
          setState(() {
            title.text = "";
            price.text = "";
            description.text = "";
            cameraProvider.picturePath = null;
          });
      }
      );
    });

    // print(cameraProvider.url);
  }
}
