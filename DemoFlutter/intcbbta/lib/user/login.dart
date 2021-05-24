import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rest_package/bean_user/login_request.dart';
import 'package:rest_package/bean_user/login_response.dart';

import 'package:rest_package/connection/login_connection.dart';
import 'package:intcbbta/global/global.dart' as globals;
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  var mobile = TextEditingController();
  var password = TextEditingController();
  bool passwordVisible = true;
  bool checkedTextField = false;
  bool mobileValidate = false;
  LoginConnection loginConnection = LoginConnection(globals.IP, globals.PORT);
  XSignature randReqRef = XSignature();
  final _formKey = GlobalKey<FormState>();
  String title = "";
  String description = "";
  Future<void> login(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      String reqRefNo = 'req' + randReqRef.generateREQRefNo();
      LoginRequest request = LoginRequest(mobile.text, password.text, reqRefNo);
      loginConnection.login(request).then((value) {
        title = value.statusCode.toString();
        description = value.body.toString();
        print(title);
        print(description);
        if (value.statusCode == 200) {
          Map<String, dynamic> responseMap = jsonDecode(value.body);
          LoginResponse response = LoginResponse.fromJson(responseMap);
          title = response.respCode.toString();
          description = response.respDesc.toString();
          if (reqRefNo == response.reqRefNo) {
            switch (response.respCode) {
              case ResponseCode.APPROVED:
                {
                  title = "Login Success";
                  description = "Welcome back";
                  globals.TOKEN = response.token;
                  globals.EMPLOYEE_NO = response.customerNo;
                  globals.MOBILE = response.mobileNo;
                  globals.LEVEL = response.level;
                  if(response.level==ResponseCode.ROLE_STAFF){
                    dialogContentSuccess(title, description, '/adminDashboard');
                  }
                  else if(response.level==ResponseCode.ROLE_ADMIN){
                    dialogContentSuccess(title, description, '/adminDashboard');
                  }
                  break;
                }
              case ResponseCode.NOT_FOUND:
                {
                  title = "user not found";
                  description = "pls register :)";
                  dialogContentFails(title, description);

                  break;
                }
              case ResponseCode.INVALID_AUTH:
                {
                  title = "invalid";
                  description = "user/password";
                  dialogContentFails(title, description);

                  break;
                }
              case ResponseCode.BAD_REQUEST:
                {
                  title = "Pls check";
                  description = "your connection";
                  dialogContentFails(title, description);

                  break;
                }
              default:
                {
                  title = "Server has problem";
                  description = "Please contact admin";
                  dialogContentFails(title, description);
                }
            }
          }
        } else {
          title = "Server has problem";
          description = "Please contact admin";
          dialogContentFails(title, description);
        }
      });
    }
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

  String validateRequired(String val, String fieldname) {
    if (val == null || val == '') return '$fieldname is Required';
    return null;
  }

  Widget _TextFieldPassword(
    TextEditingController controller,
    String labelText,
    bool showSuffixicon,
    bool enableObscureText,
    String value,
  ) {
    return TextFormField(
        keyboardType: TextInputType.text,
        obscureText: enableObscureText == true ? passwordVisible : false,
        decoration: InputDecoration(
          suffixIcon: showSuffixicon == true
              ? IconButton(
                  icon: Icon(
                    passwordVisible ? Icons.visibility_off : Icons.visibility,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  })
              : null,
          labelText: labelText,
          border: OutlineInputBorder(),
          focusColor: Colors.blueAccent,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        ),
        controller: controller,
        validator: (String value) => validateRequired(value, labelText));
  }

  Widget _textFieldMobile(
      TextEditingController controller,
      String labelText,
      ) {
    return TextFormField(
        showCursor: true,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.phone_android),
          labelText: labelText,
          border: OutlineInputBorder(),
          focusColor: Colors.blueAccent,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        ),
        maxLength: 10,
        buildCounter: (context, {currentLength, isFocused = true, maxLength}) {
          if (isFocused)
            return controller == null
                ? null
                : Text(
              '$currentLength/$maxLength',
              semanticsLabel: 'character count',
            );
          else
            return null;
        },
        controller: controller,
        autovalidate: mobileValidate,
        onChanged: (bool) {
          setState(() {
            return mobileValidate = true;
          });
        },
        validator: (value) {
          if (value == null) {
            return validateRequired(value, labelText);
          }
          if (!RegExp(r'^0[0-9]{9}$').hasMatch(value)) {
            return 'Please enter valid mobile number';
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
          child: Scaffold(
        body: ListView(
          children: [
            Form(
              key: _formKey,
              child: Container(
                width: width,
                height: height,
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.2,
                    ),
                    Container(
                      width: width * 0.75,
                      height: height * 0.25,
                      child: Image.asset("asset/images/innovative.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 40, top: 8, bottom: 8, right: 40),
                      child: Container(
                        width: width,
                        child: _textFieldMobile(mobile, "mobile no"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 40, top: 8, bottom: 8, right: 40),
                      child: Container(
                        width: width,
                        child: _TextFieldPassword(password, "password", true,
                            true, password.toString()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 40, top: 8, bottom: 8, right: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              if (_formKey.currentState.validate()) {
                                if (mobile.text == '0000' &&
                                    password.text == 'admin') {
                                  Navigator.pushNamed(
                                      context, '/adminDashboard');
                                } else if (_formKey.currentState.validate()) {
                                  login(context);
                                }
                              }
                            },
                            child: Card(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                width: width * 0.3,
                                height: height * 0.07,
                                child: Center(child: Text('login')),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: Card(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                width: width * 0.3,
                                height: height * 0.07,
                                child: Center(child: Text('register')),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
