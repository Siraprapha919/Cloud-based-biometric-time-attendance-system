import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intcbbta/global/global.dart' as globals;
import 'package:intcbbta/superUser/face_management_access.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:path_provider/path_provider.dart';

class AddBlackList extends StatefulWidget {
  @override
  _AddBlackListState createState() => _AddBlackListState();
}

class _AddBlackListState extends State<AddBlackList> {
  String url = "";
  XSignature randReqRefNo = XSignature();
  // String reqRefNo = 'REQ' + randReqRefNo.generateREQRefNo();
  var _leaveType = TextEditingController();
  bool _autovalidate = false;
  int _value = 1;
  File _imageFile;
  bool passwordVisible = true;
  TextEditingController type;
  var encode;
  var firstname = TextEditingController();
  var lastname = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  getCamera() async {
    PickedFile pickedFile = await ImagePicker()
        .getImage(source: ImageSource.camera, maxHeight: 960, maxWidth: 960);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
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
    String base64 = base64Encode(imageByte);
    print(base64);
  }

  Widget _dropFormField(
    String _value,
    String _hint,
  ) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: DropdownButtonFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            focusColor: Colors.blueAccent,
            // border: OutlineInputBorder(),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            // enabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          ),
          hint: Text(_hint),
          items: ['Block', 'Visiter']
              .map<DropdownMenuItem<String>>((String _value) {
            return DropdownMenuItem(value: _value, child: Text(_value));
          }).toList(),
          autovalidate: _autovalidate,
          onChanged: (_leave) => setState(() => _leaveType = _leave),
          validator: (value) => value == null ? '$_hint required' : null),
    );
  }

  Widget _TextField(
    TextEditingController controller,
    String labelText,
    String value,
  ) {
    return TextFormField(
        showCursor: false,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
          focusColor: Colors.blueAccent,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        ),
        controller: controller,
        validator: (String value) => validateRequired(value, labelText));
  }

  String validateRequired(String val, String fieldname) {
    if (val == null || val == '') return 'กรุณากรอก $fieldname';
    return null;
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
                'Face',
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewAccesslist()));
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
                        child:
                            _TextField(firstname, "name", firstname.toString()),
                      ),
                    ),
                    _dropFormField("type","type"),
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
                                            'ถ่ายภาพใบหน้า',
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
                          bool pass = _formKey.currentState.validate();
                          (pass) ? print('pass true') : print('pass false');
                        },
                        child: Text(
                          'เพิ่ม',
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
}
