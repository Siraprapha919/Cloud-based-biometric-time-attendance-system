import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intcbbta/model/device_all.dart';
import 'package:intcbbta/model/category.dart';
import 'package:rest_package/connection/device_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:rest_package/bean_admin/category_response.dart';
import 'package:rest_package/bean_admin/category_request.dart';
import 'package:intcbbta/global/global.dart' as globals;
import 'package:rest_package/bean_admin/device_update_request.dart';
import 'package:rest_package/bean_admin/device_update_response.dart';

class DeviceUpdate extends StatefulWidget {
  @override
  _DeviceUpdateState createState() => _DeviceUpdateState();
}

class _DeviceUpdateState extends State<DeviceUpdate> {
  TextEditingController code;
  TextEditingController nameDevice;
  TextEditingController province;
  TextEditingController district;
  TextEditingController subdistrict;
  TextEditingController address;
  bool _autovalidate = false;
  String innitValue = "-";
  XSignature randReqRef = XSignature();
  final _formKey = GlobalKey<FormState>();
  List<String> itemCategory = [];
  String msCategory = "";
  String nn = "";
  String title = "";
  String description = "";
  String categoryUpadte = "";

  String validateRequired(String val, String fieldname) {
    if (val == null || val == '') {
      return '$fieldname is Required';
    }
    return null;
  }

  @override
  void initState() {
    categoryAll(context);
  }

  Widget _TextField(
    TextEditingController controller,
    String label,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8, right: 15),
      child: TextFormField(
          // initialValue: innit,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            // labelText: labelText,
            border: OutlineInputBorder(),
            focusColor: Colors.blueAccent,
            //   floatingLabelBehavior: FloatingLabelBehavior.auto,
            contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          ),
          controller: controller,
          autovalidate: _autovalidate,
          
          validator: (value) =>
              (value == null) ? validateRequired(value, label) : null),
    );
  }

  Widget _DropFormField(String _value, String _hint) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8, right: 15),
      child: DropdownButtonFormField(
          decoration: InputDecoration(
            focusColor: Colors.blueAccent,
            border: OutlineInputBorder(),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          ),
          hint: Text(_hint),
          items: itemCategory.map<DropdownMenuItem<String>>((String _value) {
            return DropdownMenuItem(value: _value, child: Text(_value));
          }).toList(),
          autovalidate: _autovalidate,
          onChanged: (position) => setState(() {
                _value = position;
                msCategory = _value;
              }),
          validator: (values) => values == null ? '$_hint required' : null),
    );
  }

  DeviceConnection deviceConnection =
      DeviceConnection(globals.IP, globals.PORT);

  Future<void> categoryAll(BuildContext context) {
    String reqRefNo = 'req' + randReqRef.generateREQRefNo();
    CategoryRequest request = CategoryRequest(reqRefNo);
    deviceConnection.categoryAll(request, globals.TOKEN).then((value) {
      print("Response Code:" + value.statusCode.toString());
      if (value.statusCode == 200) {
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        CategoryResponse categoryResponse =
            CategoryResponse.fromJson(responseMap);
        List<Category> listCategory = [];
        for (var n in categoryResponse.category) {
          listCategory.add(Category(n["name"], n["code"], n["status"]));
        }
        listCategory.forEach((element) {
          setState(() {
            itemCategory.add(element.name);
          });
        });
      }
    });
  }

  Future<void> deviceUpdate(BuildContext context, DeviceAll deviceAll) {
    String reqRefNo = 'req' + randReqRef.generateREQRefNo();
    DeviceUpdateRequest request = DeviceUpdateRequest(
        deviceAll.rec_id, msCategory, code.text, nameDevice.text, reqRefNo);
    deviceConnection.deviceUpdate(request, globals.TOKEN).then((value) {
      title = value.statusCode.toString();
      description = value.body.toString();
      if (value.statusCode == 200) {
        // title = value.statusCode.toString();
        // description = value.body.toString();
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        DeviceUpdateResponse response =
            DeviceUpdateResponse.fromJson(responseMap);
        if (response.reqRefNo == reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          Navigator.pushNamed(context, "/deviceList");
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) => Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                child: dialogContent(title, description)),
          );
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              child: dialogContent(title, description)),
        );
      }
    });
  }

  Widget dialogContent(String title, String desc) {
    return Stack(
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
              mainAxisSize: MainAxisSize.min, // To make the card compact
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
                      Navigator.of(context).pop(); // To close the dialog
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

        // Image.asset("/asset/images/mis.gif"),
        // Image(image: AssetImage("/asset/images/mis.gif"))
        // Positioned(
        //   left: 16,
        //   right: 16,
        //   child: CircleAvatar(
        //     radius: 65,
        //     backgroundImage:AssetImage("asset/images/mis.gif"),
        //   ),
        // ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    DeviceAll deviceAll = ModalRoute.of(context).settings.arguments;
    code = TextEditingController(text: deviceAll.code);
    nameDevice = TextEditingController(text: deviceAll.name);
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamed(context, '/deviceList');
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
              title: Text(
                'Device Update',
                style: TextStyle(
                    color: Colors.blueAccent, fontSize: height * 0.05),
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
                      Navigator.pushNamed(context, '/deviceList');
                    });
              })),
          body: Form(
            key: _formKey,
            child: Container(
              width: width,
              height: height,
              color: Colors.white,
              child: ListView(
                children: <Widget>[
                  //code..text = deviceAll.code
                  _DropFormField(deviceAll.msCategory, deviceAll.msCategory),
                  _TextField(code, "code"),
                  _TextField(nameDevice, "name"),
                  // _TextField(province, "province", province.toString()),
                  // _TextField(district, "district", district.toString()),
                  // _TextField(subdistrict, "subdistrict", subdistrict.toString()),
                  // _TextField(address, "address", address.toString()),
                  InkWell(
                    onTap: () {
                      bool pass = _formKey.currentState.validate();
                      _autovalidate = _formKey.currentState.validate();
                      print(pass);
                      print(code.text);
                      print(nameDevice.text);

                      if (pass) {
                        deviceUpdate(context, deviceAll);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      alignment: Alignment.center,
                      width: width * 0.25,
                      height: height * 0.065,
                      child: Text(
                        'SUBMIT',
                        style: TextStyle(fontSize: height * 0.025),
                      ),
                    ),
                  ),
                ],
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
  }

}
