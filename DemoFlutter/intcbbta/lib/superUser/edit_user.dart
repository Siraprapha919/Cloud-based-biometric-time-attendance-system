import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intcbbta/model/userInfo.dart';
import 'package:rest_package/bean_user/position_request.dart';
import 'package:rest_package/bean_user/position_response.dart';
import 'package:rest_package/bean_user/updateInfo_request.dart';
import 'package:rest_package/bean_user/updateInfo_response.dart';
import 'package:rest_package/bean_user/user_info_request.dart';
import 'package:rest_package/bean_user/user_info_response.dart';
import 'package:rest_package/connection/user_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:intcbbta/global/global.dart' as globals;
class EditUser extends StatefulWidget {
  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  File _imageFile;
  Image _imageUser ;
  var encode = "";
  String title = "";
  String description = "";
  var firstname = TextEditingController();
  var lastname = TextEditingController();
  var mobiles = TextEditingController();
  var position = TextEditingController();
  var email = TextEditingController();
var facestatus = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String positions = "";
  final Pattern pattern_email =
      r'^(([^<>()[\]\\.,;*:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9a-z-]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  String countText = "";
  String _valuesposition = "";
  String _valueaccess = "";
  String access ="";
  String face_register = "";

  bool edit = false;
  bool isLoading = false;
  bool emailValidate = false;
  bool mobileValidate = false;
  bool nameValidate = false;
  bool _autovalidate = false;
  bool isloadinfo = false;
  bool isloadrole = false;


  //globals
  var recId;
  String employeeNo= "";
  String fname= "";
  String lname= "";
  String image= "";
  String mobileNo= "";
  String roles= "";
  String emails="";
  String faceRegisStatus="";
  String faceStatus="";
  String imageProfile = "";
  String image64 = "";

  List<String> role = [];
  XSignature randReqRef = XSignature();
  UserConnection userRegis = UserConnection(globals.IP, globals.PORT);
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
          setState(() {
            role= new List<String>.from(response.position);
           setState(() {
             isloadrole = true;
           });
          });
        }

      }
    });
  }
  Future<void> getInfo(BuildContext context)async{
    String reqRefNo = 'req' + randReqRef.generateREQRefNo();
    UserInfoRequest request = UserInfoRequest(globals.ITEM_ID,globals.ITEM_USERNAME, reqRefNo);
    userRegis.getStaffInfo(request, globals.TOKEN).then((value){
      title = value.statusCode.toString();
      description = value.body.toString();
      print(value.body.toString());
      if (value.statusCode == 200) {
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        UserInfoResponse response = UserInfoResponse.fromJson(responseMap);
        if (reqRefNo == response.reqRefNo) {
          if(response.respCode==ResponseCode.APPROVED){
            setState(() {
              isLoading = true;
              // userInfo = UserInfo(response.recId,response.employeeNo,response.fname,response.lname,response.image,response.mobileNo,response.role,response.email,response.faceRegisStatus,response.faceStatus);
              fname = response.fname;
              lname = response.lname;
             image = response.image;
             employeeNo = response.employeeNo;
              image!=null?print('image:'+image.length.toString()):null;
               emails = response.email;
              faceRegisStatus=response.faceRegisStatus;
              faceStatus = response.faceStatus;
              roles = response.role;
              recId = response.recId;
                firstname..text = response.fname;
                lastname..text = response.lname;
                mobiles..text = response.mobileNo;
                _valuesposition = response.role;
                email..text =response.email;

                if(faceStatus==ResponseCode.WHITELIST){
                  _valueaccess = 'WHITELIST';
                }else {
                  _valueaccess = 'BLACKLIST';
                }
              switch(response.faceRegisStatus){
                case ResponseCode.FACE_ALREADY_REGISTERED: facestatus..text = "Face already register.";
                break;
                case ResponseCode.FACE_NOT_REGISTER : facestatus..text = "Face not register.";
                break;
                case ResponseCode.FACE_WAITING_REGISTER: facestatus..text = "Request face register waiting approve.";
                break;
                case ResponseCode.FACE_REGISTER_APPROVED: facestatus..text = "The face is in the process of registration.";
                break;
                case ResponseCode.FACE_REGISTER_DECLINED: facestatus..text = "Face registration failed";
                break;
                case ResponseCode.FACE_UPDATE_REQUEST: facestatus..text = "Your request waiting approve.";
                break;
                case ResponseCode.FACE_UPDATE_APPROVED: facestatus..text = "Your request waiting approve.";
                break;
                case ResponseCode.FACE_UPDATE_DECLINED: facestatus..text = "Face registration failed";
                break;
              }
              facestatus..text;

            });
            setState(() {
              isloadinfo = true;
              _imageUser = Image.memory(base64Decode(image));
            });

          }else{
            dialogContentFails(title, description);
          }
        }
      }else{
        if(value.statusCode==403){
          title = "You already change mobile no.";
          description = "Please login";
          dialogContentFails(title, description);
          Navigator.pushNamed(context, '/login');
        }else{
          title = "Server has problem";
          description = "Please contact admin";
          dialogContentFails(title, description);
        }
      }
    });
  }
  Future<void> updateInfo(BuildContext context) async{
    if (_formKey.currentState.validate()&&(_imageFile!=null||image!=null)) {
      XSignature randReqRef = XSignature();
      String reqRefNo = 'req' + randReqRef.generateREQRefNo();
      print('mobile:'+mobiles.text);
      print('access:'+access);

      UpdateInfoRequest updateInfoRequest = UpdateInfoRequest(recId, employeeNo, firstname.text, lastname.text, image, mobiles.text , _valuesposition, email.text, faceRegisStatus, access, reqRefNo);
      userRegis.updateStaffInfo(updateInfoRequest,globals.TOKEN).then((value) {
        print(value.statusCode);
        print(value.statusCode);
        title = value.statusCode.toString();
        description = value.body;
        if (value.statusCode == 200) {
          setState(() {
            edit = false;
          });
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
                  dialogContentSuccess(title, description, '/viewallstaff');
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

  @override
  void initState() {
    getInfo(context);
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
            appBar:AppBar(
              title: Text(
                'User info',
                style:
                TextStyle(color: Colors.blueAccent, fontSize: height * 0.05),
              ),
              // elevation: 0.0,
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
              }),
              actions: <Widget>[
                (edit == false??true)
                    ? IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.blueAccent,
                    ),
                    onPressed: () {
                      setState(() {
                        edit = true;
                      });
                    })
                    : TextButton(
                    onPressed: () {
                      //service
                      setState(() {

                        updateInfo(context);
                      });
                    },
                    child: Text(
                      'SAVE',
                      style:
                      TextStyle(color: Colors.blueAccent, fontSize: 20),
                    ))
              ],
            ),
            body:  !(isloadinfo&&isloadrole)?Center(child: CircularProgressIndicator()):Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: <Widget>[
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
                                  backgroundImage: (_imageFile!=null??true)?FileImage(_imageFile):(_imageUser!=null??true)?MemoryImage(base64Decode(image)):AssetImage('./asset/images/logo.png'),
                              ),
                             edit?Align(
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
                    Container(
                      width: width,
                      child: _textFieldStatus(facestatus, "Face register status"),
                    ),
                    //_textFieldStatus
                    // Padding(
                    //   padding: const EdgeInsets.all(4.0),
                    //   child: Container(
                    //     width: width * 0.42,
                    //     child: _dropFormFieldAccess(),
                    //   ),
                    // ),
                  ],
                ),
              ),
            )),
        ));
  }
  getGallery() async {
    PickedFile pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, maxHeight: 960, maxWidth: 960);
    File rotatedImage =
    await FlutterExifRotation.rotateAndSaveImage(path: pickedFile.path);
    if (pickedFile != null) {
      setState(() {
        _imageFile = rotatedImage;
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
    File rotatedImage =
    await FlutterExifRotation.rotateAndSaveImage(path: pickedFile.path);
    if (pickedFile != null) {
      setState(() {
        _imageFile = rotatedImage;
        print( akaBase64(_imageFile));

      });
    }
  }
  akaBase64(File img) async {
    List<int> imageByte = await img.readAsBytesSync();
    String base64 = base64Encode(imageByte);
    setState(() {
      image  = base64;
    });
    print(image);
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
                              Navigator.pushNamed(context,routeName); // To close the dialog
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
  Widget _textFieldEmail(TextEditingController controller,String labelText,) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        enabled: edit,
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
          onSaved: (value){
            controller.text = value;
            print('email:'+controller.text);
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
  Widget _textFieldName( TextEditingController controller,String labelText,) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
          enabled: edit,
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
        onSaved: (value){
          print('name:'+controller.text);
          controller.text = value;
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
  Widget _textFieldLastName(TextEditingController controller,String labelText) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
          enabled: edit,
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
          onSaved: (value){
            setState(() {
            controller.text = value;
            print('name:'+controller.text);
          });},
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
  Widget _textFieldStatus(TextEditingController controller,String labelText) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
          enabled: false,
          showCursor: true,
          controller: controller..text,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(

            suffixStyle: TextStyle(fontSize: 15),
            labelText: labelText,
            border: OutlineInputBorder(),

            focusColor: Colors.blueAccent,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          ),


          ),
    );
  }

  Widget _textFieldMobile(TextEditingController controller, String labelText,) {
    return TextFormField(
        enabled: edit,
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
        onSaved: (value){
          setState(() {
            controller.text = value;
            print('mobile no:'+controller.text);
          });
        },
        validator: (value) {
          if (value == null) {
            return validateRequired(value, labelText);
          }
          if (!RegExp(r'^0[1-9]{9}$').hasMatch(value)) {
            return 'Please enter valid mobile number';
          }
        });
  }

  Widget _dropFormField() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        enabled: edit,
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

  Widget _dropFormFieldAccess() {
    return DropdownButtonFormField(

      iconEnabledColor: Colors.black26,
      decoration: InputDecoration(
        enabled: edit,
        focusColor: Colors.blueAccent,
        border: OutlineInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      ),

      items: ['WHITELIST','BLACKLIST'].map<DropdownMenuItem<String>>((String _value) {
        return DropdownMenuItem(value: _value, child: Text(_value));
      }).toList(),
      autovalidate: _autovalidate,
      onChanged: (value) {
        print("positon:"+value);
          _autovalidate = true;
          // ignore: unrelated_type_equality_checks
          if(value=='WHITELIST'){
            setState(() {
              access = ResponseCode.WHITELIST;
            });
          }
          // ignore: unrelated_type_equality_checks
          else if(value=='BLACKLIST'){
            setState(() {
             access = ResponseCode.BLACKLIST;
            });
          }
          print(_valueaccess);

      },
    value: _valueaccess,
    );
  }


}
