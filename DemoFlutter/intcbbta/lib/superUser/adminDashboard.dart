import 'dart:convert';
import 'package:backdrop/app_bar.dart';
import 'package:backdrop/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:rest_package/bean_user/logout_request.dart';
import 'package:rest_package/bean_user/logout_response.dart';
import 'package:rest_package/bean_user/position_request.dart';
import 'package:rest_package/bean_user/position_response.dart';
import 'package:rest_package/bean_user/user_info_request.dart';
import 'package:rest_package/bean_user/user_info_response.dart';
import 'package:rest_package/connection/login_connection.dart';
import 'package:rest_package/connection/user_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:intcbbta/global/global.dart'as globals;
import 'package:shared_preferences/shared_preferences.dart';
class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  bool isLoading =false;
  String title = '';
  String description = '';
  String faceRegis = '';
  LoginConnection connection = LoginConnection(globals.IP, globals.PORT);
  UserConnection userConnection = UserConnection(globals.IP, globals.PORT);
  XSignature randReqRef = XSignature();
  Future<void> logout(BuildContext context) async{
    String reqRefNo = 'req' + randReqRef.generateREQRefNo();
    LogoutRequest request = LogoutRequest(reqRefNo);
    connection.logout(request, globals.TOKEN).then((value) {
      title = value.statusCode.toString();
      description = value.body.toString();
      if (value.statusCode == 200) {
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        LogoutResponse response = LogoutResponse.fromJson(responseMap);
        print('reqRefNo : ' + response.reqRefNo);
        print('respCode : ' + response.respCode);
        print('respDesc : ' + response.respDesc);
        print('status code= ' + value.statusCode.toString());
        print('respDesc : ' + response.respDesc);
        if (reqRefNo == response.reqRefNo) {
          if(response.respCode==ResponseCode.APPROVED){
            title = 'Logout Success';
            description = 'Please come back again.';
            dialogContentSuccess(title, description, '/login');
          }
          else{
            dialogContentFails(title, description);
          }
        }
      } else {
        dialogContentFails(title, description);
      }
    });
  }
  Future<void> getInfo(BuildContext context)async{
    String reqRefNo = 'req' + randReqRef.generateREQRefNo();
    UserInfoRequest request = UserInfoRequest(globals.EMPLOYEE_NO, globals.MOBILE, reqRefNo);
    userConnection.getInfo(request, globals.TOKEN).then((value){
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
              globals.FIRSTNAME=response.fname;
              globals.LASTNAME =response.lname;
              globals.IMAGE=response.image;
              globals.IMAGE!=null?print('image:'+globals.IMAGE.length.toString()):null;
              globals.EMAIL=response.email;
              globals.STATUS_FACE_REGIS =response.faceRegisStatus;
              globals.FACE_STATUS = response.faceStatus;
              globals.ROLE=response.role;
              globals.REC_ID=response.recId.toString();
              print('response.fname:'+response.fname);
              /**FACE_ALREADY_REGISTER("6001", "already register"),
                  FACE_NOT_REGISTER("6002", "not registered"),
                  FACE_WAITING_REGISTER("6005", "face waiting register"),
                  FACE_REGISTER_APPROVED("6006", "face extraction success"),
                  FACE_REGISTER_REQUEST("6013", "face extraction success"),
                  FACE_REGISTER_DECLINED("6007", "face extraction declined"),
                  FACE_UPDATE_REQUEST("6008","face waiting approved"),
                  FACE_UPDATE_DECLINED("6009","face waiting approved"),
                  FACE_UPDATE_APPROVED("6010","face update approved"),*/
              print(response.faceRegisStatus);
              switch(response.faceRegisStatus){
                case ResponseCode.FACE_ALREADY_REGISTERED: faceRegis = "Congrats,your face already register.";
                break;
                case ResponseCode.FACE_NOT_REGISTER : faceRegis = "Please register your face.";
                break;
                case ResponseCode.FACE_WAITING_REGISTER: faceRegis = "Your request waiting approve.";
                break;
                case ResponseCode.FACE_REGISTER_APPROVED: faceRegis = "The face is in the process of registration.";
                break;
                case ResponseCode.FACE_REGISTER_REQUEST: faceRegis = "Your request waiting approve.";
                break;
                case ResponseCode.FACE_REGISTER_DECLINED: faceRegis = "Face registration failed,please try again";
                break;
                case ResponseCode.FACE_UPDATE_REQUEST: faceRegis = "Your request waiting approve.";
                break;
                case ResponseCode.FACE_UPDATE_APPROVED: faceRegis = "Your request waiting approve.";
                break;
                case ResponseCode.FACE_UPDATE_DECLINED: faceRegis = "Face registration failed,please try again";
                break;
              }
              faceRegis;
            });
          }
          else{
            dialogContentFails(title, description);
          }
        }
      } else {
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
  Future<void> getRole(BuildContext context)async{
    XSignature randReqRef = XSignature();
    String reqRefNo = 'req' + randReqRef.generateREQRefNo();
    PositionRequest request = PositionRequest(reqRefNo);
    userConnection.position(request).then((value) {
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
            globals.POSITIONLIST = new List<String>.from(response.position);
          });
        }

      }
    });
  }
  saveValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('imageProfile',globals.IMAGE_PROFILE);
  }
  @override
  void initState() {
    print('image profile:'+globals.IMAGE_PROFILE);
    getInfo(context);
    getRole(context);

  }
  @override
  void dispose() {
    globals.IMAGE = null;
    globals.IMAGE_PROFILE = null;
  }
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      getInfo(context);
    });
    return null;
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
        child: BackdropScaffold(
          appBar: BackdropAppBar(
            backgroundColor: Colors.blueAccent,
          ),
          backgroundColor: Colors.blueAccent,
          headerHeight: height*0.6,
          backLayer: Container(
            padding: EdgeInsets.only(left: 20),
            alignment: Alignment.centerLeft,
            width: width,
            color: Colors.blueAccent,
            child: Padding(
              padding: const EdgeInsets.only(left: 10,top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Padding(
                        padding: EdgeInsets.all(4),
                        child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/updateInfo');
                            },
                            child: Text('Update Info',style: TextStyle(
                                color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold
                            ),)
                        )
                    ),
                  ),
                  Container(
                    child: Padding(
                        padding: EdgeInsets.all(4),
                        child: InkWell(
                            onTap: () => logout(context),
                            child: Text('Log out',style: TextStyle(
                                color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold
                            ),)
                        )
                    ),
                  ),

                ],
              ),
            ),
          ),
          frontLayer: RefreshIndicator(
            key: refreshKey,
            onRefresh: refreshList,
            child: ListView(
                children: [Stack(
                  children: [
                    Container(
                      width: width,
                      height: height * 0.45,
                      color: Colors.blueAccent,
                      // decoration: BoxDecoration(
                      //   boxShadow: [
                      //     BoxShadow(
                      //       color: Colors.grey.withOpacity(0.5),
                      //       spreadRadius: 5,
                      //       blurRadius: 7,
                      //       offset: Offset(0, 3), // changes position of shadow
                      //     ),
                      //   ],
                      //   color: Colors.blueAccent,
                      // ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Center(
                                    child: CircleAvatar(
                                      maxRadius: width*0.2,
                                      foregroundColor: Colors.white,
                                      backgroundColor:Colors.white,
                                      child: Stack(
                                          children:<Widget>[
                                            CircleAvatar(
                                              maxRadius: width*0.185,
                                              backgroundImage: (globals.IMAGE!=null??true)?MemoryImage(base64Decode(globals.IMAGE)):AssetImage('./asset/images/logo.png'),
                                            ),
                                          ]
                                      ),
                                    ),
                                  ),
                                ]
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8,right: 8,top: 1),
                            child: Container(
                              width: width,
                              margin: EdgeInsets.only(left: 20),
                              // color: Colors.amber,
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(globals.FIRSTNAME+' '+globals.LASTNAME,
                                      style: TextStyle(fontSize: 30,color: Colors.white),),
                                    Text(globals.ROLE,maxLines: 2,style: TextStyle(fontSize: 25,color:Colors.white,),),
                                    Text( faceRegis,style: TextStyle(fontSize: 20,color: Colors.white))
                                  ],
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: height * 0.4),
                      height: height * 0.625,
                      width: width,

                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     Navigator.pushNamed(context, '/requestLeave');
                          //   },
                          //   child: myButton(
                          //     context, width, height, 'Leave Request',
                          //     Icons.add_circle_outline_rounded,),
                          // ),
                          ((globals.STATUS_FACE_REGIS == ResponseCode.FACE_REGISTER_DECLINED&&globals.LEVEL!=ResponseCode.ROLE_ADMIN)||(globals.STATUS_FACE_REGIS == ResponseCode.FACE_NOT_REGISTER&&globals.LEVEL!=ResponseCode.ROLE_ADMIN))
                              ? InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/faceRegis');
                            },
                            child: myButton(context, width, height,
                                'face Register', Icons.face_outlined),
                          ):Container(),
                          ((globals.STATUS_FACE_REGIS == ResponseCode.FACE_ALREADY_REGISTERED||globals.STATUS_FACE_REGIS == ResponseCode.FACE_UPDATE_REQUEST||globals.STATUS_FACE_REGIS == ResponseCode.FACE_UPDATE_DECLINED)&&globals.LEVEL==ResponseCode.ROLE_STAFF)
                              ? InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/faceUpdate');
                            },
                            child: myButton(context, width, height,
                                'face update', Icons.face_retouching_natural),
                          )
                              : Container(),
                          (globals.LEVEL==ResponseCode.ROLE_ADMIN)?InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/ViewVisiter');
                            },
                            child: myButton(
                                context, width, height, 'visiter', Icons.person),
                          ):Container(),
                          (globals.LEVEL==ResponseCode.ROLE_ADMIN)?InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/deviceList');
                            },
                            child: myButton(
                                context, width, height, 'device', Icons.devices),
                          ):Container(),
                          // (globals.LEVEL==ResponseCode.ROLE_ADMIN)?InkWell(
                          //   onTap: () {
                          //     Navigator.pushNamed(context, '/configmenu');
                          //   },
                          //   child: myButton(context, width, height, 'config',
                          //       Icons.lock_clock),
                          // ):Container(),
                          (globals.LEVEL==ResponseCode.ROLE_ADMIN)?InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/viewallstaff');
                            },
                            child: myButton(
                                context, width, height, 'face', Icons.face_outlined),
                          ):Container(),
                          // InkWell(
                          //   onTap: () {
                          //     Navigator.pushNamed(context, '/approveLeaveRequest');
                          //   },
                          //   child: myButton(
                          //       context, width, height, 'approve', Icons.approval),
                          // ),
                        ],
                      ),
                    )
                  ],
                ),]
            ),
          ),
        ),
      ),
    );
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
  myButton(BuildContext context, double width, double height, String text,
      IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 5),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Container(
          height: height * 0.07,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Icon(icon,size: 30,),
              SizedBox(
                width: 15,
              ),
              Text(
                text,
                style: TextStyle(fontSize: height * 0.03),
              ),
            ],
          ),
        ),
      ),
    );
  }

  faceRegisBTN(
      BuildContext context,
      double width,
      double height,
      String text,
      ) {
    return Card(
      elevation: 5,
      child: Container(
        width: width * 0.82,
        height: height * 0.1,
        child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: height * 0.03),
              textAlign: TextAlign.center,
            )),
      ),
    );
  }

  amount(BuildContext context, double width, double height, String amount,
      String total, String type) {
    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8,bottom: 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            amount + '/' + total+'\n$type',
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),
            textAlign: TextAlign.center,
          ),

        ],
      ),
    );
  }


}