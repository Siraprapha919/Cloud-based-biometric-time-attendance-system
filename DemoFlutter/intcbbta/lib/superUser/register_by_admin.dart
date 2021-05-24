import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rest_package/bean_user/position_request.dart';
import 'package:rest_package/bean_user/position_response.dart';
import 'package:rest_package/bean_user/registration_request.dart';
import 'package:rest_package/bean_user/registration_response.dart';
import 'package:rest_package/connection/user_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:intcbbta/global/global.dart' as globals;
class RegisterByAdmin extends StatefulWidget {
  @override
  _RegisterByAdminState createState() => _RegisterByAdminState();
}

class _RegisterByAdminState extends State<RegisterByAdmin> {
  File _imageFile;
  bool passwordVisible = true;
  bool re_passwordVisible = true;
  var encode;
  String title = "";
  String description = "";
  var firstname = TextEditingController();
  var lastname = TextEditingController();
  var mobiles = TextEditingController();
  var position = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var repassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final Pattern pattern_email =
      r'^(([^<>()[\]\\.,;*:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9a-z-]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  String countText = "";
  String _valuesposition = "";
  bool pwdValidate = false;
  bool re_pwdValidate = false;
  bool emailValidate = false;
  bool mobileValidate = false;
  bool nameValidate = false;
  bool _autovalidate = false;
  bool lastnameValidate = false;
  String image64 = "";
  List<String> role = [];

  UserConnection userRegis = UserConnection(globals.IP, globals.PORT);

  Future<void> register(BuildContext context) async {
    String str = mobiles.text;
    String mobileNo = '66' + str.substring(1, str.length);
    if (_formKey.currentState.validate()) {
      XSignature randReqRef = XSignature();
      String reqRefNo = 'req' + randReqRef.generateREQRefNo();
      RegisterRequest request = RegisterRequest(
          firstname: firstname.text,
          lastname: lastname.text,
          mobile: mobileNo,
          role: _valuesposition,
          email: email.text,
          password: password.text,
          img64: image64,
          reqRefNo: reqRefNo);
      print('image64:'+image64);
      userRegis.register(request).then((value) {
        print(value.statusCode);
        print(value.statusCode);
        if (value.statusCode == 200) {
          Map<String, dynamic> responseMap = jsonDecode(value.body);
          RegisterResponse response = RegisterResponse.fromJson(responseMap);
          print('reqRefNo : ' + response.reqRefNo);
          print('respCode : ' + response.respCode);
          print('respDesc : ' + response.respDesc);
          // Navigator.pushNamed(context, '/login');
          if (reqRefNo == response.reqRefNo) {
            switch (response.respCode) {
              case ResponseCode.APPROVED:
                {
                  title = "Register Success";
                  description = "Please login";
                  dialogContentSuccess(title, description, '/viewallstaff');
                  break;
                }
              case ResponseCode.ALREADY_EXISTS_MOBILE_NO:
                {
                  title = "Already exist mobile no";
                  description = "Please login";
                  dialogContentFails(title, description);
                  break;
                }
              case ResponseCode.INVALID_AUTH:
                {
                  title = "invalid";
                  description = "mobile no or password";
                  dialogContentFails(title, description);
                  break;
                }
              case ResponseCode.BAD_REQUEST:
                {
                  title = "Please check";
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

  Future<void> getRole(BuildContext context)async{
    XSignature randReqRef = XSignature();
    String reqRefNo = 'req' + randReqRef.generateREQRefNo();
    PositionRequest request = PositionRequest(reqRefNo);
    userRegis.position(request).then((value) {
      print(value.body);
      if(value.statusCode==200){
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        PositionResponse response = PositionResponse.fromJson(responseMap);
        if(response.reqRefNo==reqRefNo&&response.respCode==ResponseCode.APPROVED){
          print(response.position.toList());
          // for(List i in response.position.toList()){
          //   role.add(i.toString());
          // }
          setState(() {
            role= new List<String>.from(response.position);
          });
        }

      }
    });
  }

  getCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxHeight: 960,
        maxWidth: 960,
        imageQuality: 100);
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
    setState(() {
      image64  = base64;
    });
    return base64;
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

  String validateRequired(String val, String fieldname) {
    return (val == null || val == '') ? '$fieldname is Required' : null;
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

  Widget _textFieldEmail(
      TextEditingController controller,
      String labelText,
      ) {
    return Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextFormField(
          showCursor: true,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.email_outlined),
            labelText: labelText,
            border: OutlineInputBorder(),
            focusColor: Colors.blueAccent,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          ),
          controller: controller,
          maxLength: 50,
          buildCounter: (context,
              {currentLength, isFocused = true, maxLength}) {
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
          autovalidate: emailValidate,
          onChanged: (value){
            value!=null||value!=''?emailValidate=true:emailValidate=false;},

        )
    );
  }

  Widget _textFieldPassword(
      TextEditingController controller,
      String labelText,
      bool showSuffixicon,
      bool enableObscureText,
      ) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
          showCursor: true,
          keyboardType: TextInputType.text,
          maxLength: 16,
          buildCounter: (context,
              {currentLength, isFocused = true, maxLength}) {
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
            // counterText: controller.text.length.toString() + '/8-16',
            border: OutlineInputBorder(),
            focusColor: Colors.blueAccent,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          ),
          controller: controller,

          onChanged: (bool) {
            setState(() {
              return pwdValidate = true;
            });
          },
          validator: (value) {
            if (value == null) {
              return validateRequired(value, labelText);
            }
            if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,16}$')
                .hasMatch(value)) {
              return 'Please enter valid password';
            }
          }
      ),
    );
  }

  Widget _textFieldName(
      TextEditingController controller,
      String labelText,
      ) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
          showCursor: true,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            suffixText: 'Character a-z or A-Z',
            suffixStyle: TextStyle(fontSize: 15),
            labelText: labelText,
            border: OutlineInputBorder(),
            focusColor: Colors.blueAccent,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          ),
          maxLength: 20,
          buildCounter: (context,
              {currentLength, isFocused = true, maxLength}) {
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
          autovalidate: lastnameValidate,
          onChanged: (bool) {
            setState(() {
              return lastnameValidate = true;
            });
          },
          validator: (value) {
            if (value == null) {
              return validateRequired(value, labelText);
            }
            if (!RegExp(r'^[a-zA-Z]+(([,. -][a-zA-Z ])?[a-zA-Z]*)*$')
                .hasMatch(value)) {
              return 'Please enter valid your name';
            }
          }),
    );
  }

  Widget _textFieldRePassword(
      TextEditingController controller,
      String labelText,
      bool showSuffixicon,
      bool enableObscureText,
      ) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
          showCursor: true,
          keyboardType: TextInputType.text,
          obscureText: enableObscureText == true ? re_passwordVisible : false,
          decoration: InputDecoration(
            helperText: '',
            suffixIcon: showSuffixicon == true
                ? IconButton(
                icon: Icon(
                  re_passwordVisible
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  setState(() {
                    re_passwordVisible = !re_passwordVisible;
                  });
                })
                : null,
            labelText: labelText,
            border: OutlineInputBorder(),
            focusColor: Colors.blueAccent,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          ),
          controller: controller,
          maxLength: 16,
          buildCounter: (context,
              {currentLength, isFocused = true, maxLength}) {
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
          autovalidate: re_pwdValidate,
          onChanged: (bool) {
            setState(() {
              return re_pwdValidate = true;
            });
          },
          validator: (String value) {
            if (value == null) {
              return validateRequired(value, labelText);
            }
            if (value != password.text) {
              return 'Please try again, your password do not match.';
            }
          }),
    );
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

  Widget _dropFormField(
      String _hint,
      ) {
    return DropdownButtonFormField(
        decoration: InputDecoration(
          focusColor: Colors.blueAccent,
          border: OutlineInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        ),
        hint: Text(_hint),
        items: role.map<DropdownMenuItem<String>>((String _value) {
          return DropdownMenuItem(value: _value, child: Text(_value));
        }).toList(),
        autovalidate: _autovalidate,
        onChanged: (position) {
          setState(() {
            _autovalidate = true;
          });
          _valuesposition = position;
        },
        validator: (value) => value == null ? '$_hint required' : null);
  }


  @override
  void initState() {
    getRole(context);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamed(context, '/viewallstaff');
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              title: Text(
                'Register',
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
                      Navigator.pushNamed(context, '/viewallstaff');
                    });
              })),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child:

                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          maxRadius: 80.25,
                          foregroundColor: Colors.blueAccent,
                          backgroundColor:Colors.blueAccent,
                          child: Container(
                            width: 150,
                            height: 150,
                            // color: Colors.blueAccent,
                            child: Stack(
                                children:<Widget>[
                                  CircleAvatar(
                                    maxRadius: 80,
                                    backgroundImage: (_imageFile!=null??true)?FileImage(_imageFile):AssetImage('./asset/images/logo.png'),
                                  ),
                                  true?Align(
                                    alignment: Alignment.bottomRight,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.blueAccent,
                                      child: IconButton(icon: Icon(Icons.edit,color: Colors.white), onPressed: (){
                                        showDialog(context: context, builder: (BuildContext context)=>SimpleDialog(
                                          children:<Widget> [
                                            ListTile(
                                              leading: Icon(Icons.icecream,color: Colors.blueAccent,),
                                              title: Text('Image Source'),
                                            ),
                                            ListTile(
                                              leading: Icon(Icons.camera_alt,color: Colors.blueAccent,),
                                              title: Text('Camera'),
                                              onTap: (){
                                                getCamera();
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            ListTile(
                                              leading: Icon(Icons.image,color: Colors.blueAccent,),
                                              title: Text('Gallery'),
                                              onTap: (){
                                                getGallery();
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ));
                                      }),
                                    ),
                                  ):Container(),
                                ]
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),


                  _textFieldName(firstname, "firstname"),
                  Container(
                    width: width,
                    child: _textFieldName(lastname, "lastname"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: width * 0.42,
                      child: _textFieldMobile(mobiles, "mobile no."),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: width * 0.42,
                      child: _dropFormField("position"),
                    ),
                  ),
                  Container(
                    width: width,
                    child: _textFieldEmail(email, "email"),
                  ),
                  Container(
                    width: width,
                    child:
                    _textFieldPassword(password, "password", true, true),
                  ),
                  Container(
                    width: width,
                    child: _textFieldRePassword(
                        repassword, "password", true, true),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 5),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if( _formKey.currentState.validate()&&_imageFile!=null){
                            register(context);
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        alignment: Alignment.center,
                        width: width * 0.25,
                        height: height * 0.065,
                        child: Text(
                          'Register',
                          style: TextStyle(fontSize: height * 0.025),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
