import 'dart:convert';

import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rest_package/bean_user/faceExtraction_request.dart';
import 'package:rest_package/bean_user/faceExtraction_response.dart';

import 'package:rest_package/connection/face_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:intcbbta/global/global.dart' as globals;

class FaceUpdate extends StatefulWidget {
  @override
  _FaceUpdateState createState() => _FaceUpdateState();
}

class _FaceUpdateState extends State<FaceUpdate> {
  int _value = 1;
  File _imageFile;

  bool passwordVisible = true;
  var encode;
  var firstname = TextEditingController();
  var lastname = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var mobile = TextEditingController();
  var password = TextEditingController();
  FaceExtractionConnection faceExtractionConnection =
      FaceExtractionConnection(globals.IP, globals.PORT);
  bool checkedTextField = false;
  String base64 = "";
  XSignature randReqRef = XSignature();
  String title = "";
  String description = "";

  getCamera() async {
    PickedFile pickedFile = await ImagePicker()
        .getImage(source: ImageSource.camera, maxHeight: 960, maxWidth: 960);
    File rotatedImage =
        await FlutterExifRotation.rotateAndSaveImage(path: pickedFile.path);

    if (pickedFile != null) {
      setState(() {
        // _imageFile = File(pickedFile.path);
        _imageFile = rotatedImage;
        akaBase64(_imageFile);
      });
    }
  }

  getGallery() async {
    PickedFile pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, maxHeight: 960, maxWidth: 960);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        akaBase64(_imageFile);
      });
    }
  }

  akaBase64(File img) async {
    List<int> imageByte = await img.readAsBytesSync();
    base64 = base64Encode(imageByte);
    print(base64);
  }

  strToImg(String base64) {
    Uint8List bytes = base64Decode(base64);
    _imageFile.writeAsBytesSync(bytes);
  }

  Future<void> faceUpdates(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      String reqRefNo = 'REQ' + randReqRef.generateREQRefNo();
      FaceExtractionRequest request = FaceExtractionRequest(
          userid:globals.EMPLOYEE_NO,
          image: base64,
          username: globals.FIRSTNAME +" "+ globals.LASTNAME,
          status: "EMPLOYEE",
          reqRefNo: reqRefNo);
      print("Tokens:"+globals.TOKEN);
      faceExtractionConnection.faceUpdate(request,globals.TOKEN).then((value) {
        print('value.status : ' + value.statusCode.toString());
        if (value.statusCode == 200) {
          Map<String, dynamic> responseMap = jsonDecode(value.body);
          FaceExtractionResponse response =
          FaceExtractionResponse.fromJson(responseMap);
          print('reqRefNo : ' + response.reqRefNo);
          print('respCode : ' + response.respCode);
          print('respDesc : ' + response.respDesc);
          title = response.respCode;
          description = response.respDesc;
          if (reqRefNo == response.reqRefNo &&
              response.respCode == ResponseCode.FACE_WAITING_REGISTER) {
            title = "Success";
            dialogContentSuccess(title, "", '/adminDashboard');
          }
        }
      });
    } else {
      dialogContentFails(title, description);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamed(context, '/adminDashboard');
      },
          child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              title: Text(
                'FACE UPDATE',
                style:
                    TextStyle(color: Colors.blueAccent, fontSize: height * 0.05),
              ),
              elevation: 0.0,
              backgroundColor: Colors.white,
              leading: Builder(builder: (BuildContext context) {
                return IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_sharp,
                      color: Colors.blueAccent,
                    ),
                    onPressed: () {
                     Navigator.pushNamed(context, '/adminDashboard');
                    });
              })),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: width,
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: width,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black38,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.face_outlined),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          child: Text(
                                            'Take a picture',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          icon: Icon(Icons.add_a_photo_outlined),
                                          onPressed: () async {
                                            getCamera();
                                          }),
                                      IconButton(
                                          icon: Icon(Icons.add_circle_outline),
                                          onPressed: () async {
                                            getGallery();
                                          })
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            (_imageFile != null)
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10),
                                    child: Divider(
                                      height: 5,
                                      thickness: 1,
                                    ),
                                  )
                                : Container(),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: (_imageFile != null)
                                  ? Image.file(_imageFile)
                                  : Container(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        color: Colors.white,
                        onPressed: () {
                          print("token:" + globals.TOKEN);
                          print("validate form key:" +
                              _formKey.currentState.validate().toString());
                          if (_formKey.currentState.validate()) {
                            faceUpdates(context);
                          }
                        },
                        child: Text(
                          'submit',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
Future dialogContentSuccess(String title, String desc, String routeName) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Stack(
            children: <Widget>[
              Card(
                color: Colors.transparent,
                shadowColor: Colors.transparent,
                child: Container(
                  padding: EdgeInsets.only(
                    top: 80,
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  margin: EdgeInsets.only(top: 65),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize:
                    MainAxisSize.min, // To make the card compact
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        desc,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 24.0),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, routeName); // To close the dialog
                          },
                          child: Text(
                            "OK",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 16,
                right: 16,
                child: Image(
                    image: AssetImage('./asset/images/wink.gif'),
                    width: 175,
                    height: 175),
              ),
            ],
          )));
}
Future dialogContentFails(String title, String desc) {
  return showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: Stack(
            children: <Widget>[
              Card(
                color: Colors.transparent,
                shadowColor: Colors.transparent,
                child: Container(
                  padding: EdgeInsets.only(
                    top: 80,
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  margin: EdgeInsets.only(top: 65),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize:
                    MainAxisSize.min, // To make the card compact
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        desc,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 24.0),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pop(); // To close the dialog
                          },
                          child: Text(
                            "OK",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 16,
                right: 16,
                child: Image(
                    image: AssetImage('./asset/images/smile.gif'),
                    width: 175,
                    height: 175),
              ),
            ],
          )));
}}

