import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intcbbta/model/category.dart';
import 'package:rest_package/bean_admin/device_register_request.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:rest_package/connection/device_connection.dart';
import 'package:intcbbta/global/global.dart' as globals;
import 'package:rest_package/bean_admin/category_request.dart';
import 'package:rest_package/bean_admin/category_response.dart';
import 'package:rest_package/bean_admin/device_register_response.dart';

class AddDevice extends StatefulWidget {
  @override
  _AddDeviceState createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  var code = TextEditingController();
  var nameDevice = TextEditingController();
  var province = TextEditingController();
  var district = TextEditingController();
  var subdistrict = TextEditingController();
  var address = TextEditingController();
  bool _autovalidate = false;
  XSignature randReqRef = XSignature();
  final _formKey = GlobalKey<FormState>();
  List<String> itemCategory = [];
  String msCategory="";

  @override
  void initState() {
    getCategory(context);
  } // List category = [];

  DeviceConnection deviceConnection =
      DeviceConnection(globals.IP, globals.PORT);
  Future<void> getCategory(BuildContext context) {
    String reqRefNo = 'req' + randReqRef.generateREQRefNo();
    CategoryRequest request = CategoryRequest(reqRefNo);
    deviceConnection.category(request, globals.TOKEN).then((value) {
      print("Response Code:" + value.statusCode.toString());
      String title = value.statusCode.toString();
      String description = value.body;
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

  Future<void> addDevice(BuildContext context) async {
    String reqRefNo = 'req' + randReqRef.generateREQRefNo();
    DeviceRegisterRequest request = DeviceRegisterRequest(msCategory, code.text, nameDevice.text, reqRefNo);
    deviceConnection.deviceRegister(request, globals.TOKEN).then((value){
      String title = value.statusCode.toString();
      String description = value.body;
      Map<String,dynamic> responseMap = jsonDecode(value.body);
      DeviceRegisterResponse response = DeviceRegisterResponse.fromJson(responseMap);
      if(value.statusCode==200){
       if(response.reqRefNo==reqRefNo){
          if(response.respCode==ResponseCode.APPROVED){
            title = 'Success';
            description = 'Insert Device Success';
           dialogContentSuccess(title, description, '/deviceList');
          }
          else{
            title ='Duplicate';
            description = response.respDesc;
            dialogContentFails(title, description);
          }
       }

      }else{
        title ='Duplicate';
        description = response.respDesc;
        dialogContentFails(title, description);
      }
    });
  }

  String validateRequired(String val, String fieldname) {
    if (val == null || val == '') return '$fieldname is Required';
    return null;
  }

  Widget _TextField(
    TextEditingController controller,
    String labelText,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8, right: 15),
      child: TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(),
            focusColor: Colors.blueAccent,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          ),
          controller: controller,
          autovalidate: _autovalidate,
          validator: (String value) => validateRequired(value, labelText)),
    );
  }

  Widget _DropFormField(
    String _value,
    String _hint,
  ) {
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
          onChanged: (position) => setState(()
          {_value = position;
          msCategory=_value;}),
          validator: (value) => value == null ? '$_hint required' : null),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: WillPopScope(
      onWillPop: () {
        Navigator.pushNamed(context, '/deviceList');
      },
              child: Scaffold(
          appBar: AppBar(
              title: Text(
                'Device Registration',
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
                      Navigator.pop(context);
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
                  _DropFormField("categary", "categary"),
                  _TextField(code, "code", code.toString()),
                  _TextField(nameDevice, "name", nameDevice.toString()),
                  // _TextField(province, "province", province.toString()),
                  // _TextField(district, "district", district.toString()),
                  // _TextField(subdistrict, "subdistrict", subdistrict.toString()),
                  // _TextField(address, "address", address.toString()),
                  InkWell(
                    onTap: () {
                      bool pass = _formKey.currentState.validate();
                      (pass) ? addDevice(context) : print('pass false');
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
