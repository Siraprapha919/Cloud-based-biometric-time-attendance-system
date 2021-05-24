import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rest_package/bean_user/registration_request.dart';
import 'package:rest_package/bean_user/registration_response.dart';
import 'package:rest_package/connection/user_connection.dart';
import 'package:intcbbta/global/global.dart' as globals;
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:rest_package/bean_user/updateInfo_request.dart';
import 'package:rest_package/bean_user/updateInfo_response.dart';
import 'package:rest_package/bean_user/position_request.dart';
import 'package:rest_package/bean_user/position_response.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File _imageFile;
  var encode = "";
  String title = "";
  String description = "";
  var firstname = TextEditingController();
  var lastname = TextEditingController();
  var mobiles = TextEditingController();
  var position = TextEditingController();
  var email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String positions = '';
  final Pattern pattern_email =
      r'^(([^<>()[\]\\.,;*:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9a-z-]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  String countText = "";
  String _valuesposition = "";
  bool emailValidate = false;
  bool mobileValidate = false;
  bool nameValidate = false;
  bool _autovalidate = false;
  String imageProfile = globals.IMAGE_PROFILE;
  List<String> role = [];
  UserConnection userRegis = UserConnection(globals.IP, globals.PORT);
  Future<void> updateInfo(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      XSignature randReqRef = XSignature();
      String reqRefNo = 'req' + randReqRef.generateREQRefNo();
      String mobileNo = '66'+mobiles.text.substring(1,mobiles.text.length);
      print('mobile:'+mobiles.text);
      UpdateInfoRequest updateInfoRequest = UpdateInfoRequest(globals.REC_ID, globals.EMPLOYEE_NO, firstname.text, lastname.text, globals.IMAGE,mobileNo , _valuesposition, email.text, globals.STATUS_FACE_REGIS, globals.FACE_STATUS, reqRefNo);
      userRegis.updateInfo(updateInfoRequest,globals.TOKEN).then((value) {
        print(value.statusCode);
        print(value.statusCode);
        title = value.statusCode.toString();
        description = value.body;
        if (value.statusCode == 200) {
          Map<String, dynamic> responseMap = jsonDecode(value.body);
          UpdateInfoResponse response = UpdateInfoResponse.fromJson(responseMap);
          print('reqRefNo : ' + response.reqRefNo);
          print('respCode : ' + response.respCode);
          print('respDesc : ' + response.respDesc);

          if (reqRefNo == response.reqRefNo) {
            switch (response.respCode) {
              case ResponseCode.APPROVED:
                {
                  title = "Success";
                  description = "Already update your info.";
                  dialogContentSuccess(title, description, '/adminDashboard');
                  break;
                }
              case ResponseCode.BAD_REQUEST:
                {
                  title = "Too many request";
                  description = "Please try again";
                  dialogContentFails(title, description);
                  break;
                }
              case ResponseCode.ALREADY_EXISTS_MOBILE_NO:
                {
                  title = "Already exist mobile no.";
                  description = "Please enter valid mobile no.";
                  dialogContentFails(title, description);
                  break;
                }
              case ResponseCode.INVALID_EMAIL:
                {
                  title = "Already exist email.";
                  description = "Please enter valid email.";
                  dialogContentFails(title, description);
                  break;
                }
              case ResponseCode.INTERNAL_ERROR:
                {
                  title = "Server Error";
                  description = "Please try again later.";
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
       if(value.statusCode == 403){
         title = "You already change mobile no.";
         description = "Please login";
         dialogContentFails(title, description);
        Navigator.pushNamed(context, '/login');
        }else{
         title = "Server has problem";
         description = "Please contact admin";
         dialogContentFails(title, description);
       }}
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

  @override
  void initState() {
    getRole(context);
    setState(() {
      firstname..text = globals.FIRSTNAME;
      lastname..text = globals.LASTNAME;
      mobiles..text = globals.MOBILE;
      _valuesposition = globals.ROLE;
      email..text = globals.EMAIL;
      imageProfile = "";
    });
    print('firstname:'+firstname.text);
    print('lastname:'+lastname.text);
    print('mobiles:'+mobiles.text);
    print(_valuesposition);
    print(email);
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
            appBar: AppBar(
              actions: <Widget>[
                IconButton(icon: Icon(Icons.refresh,color: Colors.blueAccent,),
                    onPressed: ()=> initState()
              )],
                title: Text(
                  'Update Profile',
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
                       Navigator.pushNamed(context, '/adminDashboard');
                      });
                })),
            body: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: <Widget>[
                    _textFieldName(firstname, "firstname"),
                    Container(
                      width: width,
                      child: _textFieldLastName(lastname, "lastname"),
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
                        child: _dropFormField(),
                      ),
                    ),
                    Container(
                      width: width,
                      child: _textFieldEmail(email, "email"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 5),
                      child: InkWell(
                        onTap: () {
                          updateInfo(context);
                          setState(() {
                            globals.IMAGE_PROFILE = imageProfile;
                            _formKey.currentState.validate();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4)),
                          ),
                          alignment: Alignment.center,
                          width: width * 0.25,
                          height: height * 0.065,
                          child: Text(
                            'Update',
                            style: TextStyle(fontSize: height * 0.025),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
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
    imageProfile = base64;
    print(base64);
    return base64;
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

          onChanged: (value)=>(value?.isNotEmpty??true)?(){
            if(value?.isEmpty??true){
              if(!RegExp(pattern_email).hasMatch(value)) {
                return 'Please enter valid email.';
              }
            }
          }:''

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

  Widget _textFieldLastName(
      TextEditingController controller,
      String labelText
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
  ) {
    return DropdownButtonFormField(
        decoration: InputDecoration(
          focusColor: Colors.blueAccent,
          border: OutlineInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        ),

        items: role.map<DropdownMenuItem<String>>((String _value) {
          return DropdownMenuItem(value: _value, child: Text(_value));
        }).toList(),
        autovalidate: _autovalidate,
        onChanged: (positions) {
          setState(() {
            _autovalidate = true;
            _valuesposition = positions;
          }
          );
        },
        value: _valuesposition,
       );
  }

}
