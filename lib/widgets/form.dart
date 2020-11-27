import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/camera.dart';

class FormWidget extends StatefulWidget {
  final formKey;
  final String imagePath;

  const FormWidget({this.formKey, this.imagePath});

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  bool openCameraOptions = false;
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController imageUrl = TextEditingController();

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
            if (openCameraOptions && widget.imagePath == null) imageButtons(),
            Text("or"),
            editText("imageUrl", "Please enter text!", imageUrl),
            if (widget.imagePath != null)
              Container(
                width: 100,
                height: 100,
                child: Image.file(File(widget.imagePath)),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                color: Colors.green,
                textColor: Colors.white,
                onPressed: () {
                  if (widget.formKey.currentState.validate()) {
                    addProduct(productsData.items.length);
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
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

  Widget editText(
      String fieldName, String errorMessage, TextEditingController text) {
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

  Widget imageButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RaisedButton(
          color: Colors.green,
          textColor: Colors.white,
          onPressed: () {},
          child: Text('open gallery'),
        ),
        RaisedButton(
          color: Colors.green,
          textColor: Colors.white,
          onPressed: () {
            initializeCamera();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TakePictureScreen(camera: firstCamera)));
          },
          child: Text('open camera'),
        ),
      ],
    );
  }

  Future<void> addProduct(int id) {
    return products.add({
      "id": id.toString(),
      "title": title.text,
      "imageUrl": imageUrl.text,
      "isFavorite": false,
      "description": description.text,
      "price": double.parse(price.text)
    });
  }

  void initializeCamera() async {
    cameras = await availableCameras();
    firstCamera = cameras.first;
  }
}
