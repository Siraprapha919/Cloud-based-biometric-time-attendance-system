import 'dart:convert';
import 'dart:ui';

import 'package:backdrop/app_bar.dart';
import 'package:backdrop/backdrop.dart';
import 'package:backdrop/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intcbbta/user/requested_leaved.dart';
import 'package:intcbbta/global/global.dart' as globals;
import 'package:intl/intl.dart';
import 'package:rest_package/bean_user/getInfo_request.dart';
import 'package:rest_package/bean_user/logout_request.dart';
import 'package:rest_package/bean_user/logout_response.dart';
import 'package:rest_package/bean_user/user_info_request.dart';
import 'package:rest_package/bean_user/user_info_response.dart';
import 'package:rest_package/connection/login_connection.dart';
import 'package:rest_package/connection/user_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  String title = '';
  String description = '';
  bool isLoading =false;
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
            setState(() {
              isLoading= true;
            });

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
              globals.FIRSTNAME = response.fname;
              globals.LASTNAME =response.lname;
              globals.IMAGE=response.image;
              globals.EMAIL=response.email;
              globals.STATUS_FACE_REGIS =response.faceRegisStatus;
              globals.ROLE=response.role;
              globals.REC_ID=response.recId.toString();
              print('response.fname:'+response.fname);
            });
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

  saveValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('key', "value");
  }

  @override
  void initState() {
    getInfo(context);
    print('imageglobals:'+globals.IMAGE_PROFILE);
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
                children: <Widget>[
                  Container(
                    child: Padding(
                        padding: EdgeInsets.all(4),
                        child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/updateInfo');
                            },
                            child: Text('Setting',style: TextStyle(
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
              children: [
                Stack(
                children: [
                  Container(
                    width: width,
                    height: height * 0.35,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0,3), // changes position of shadow
                          ),
                        ],
                        color: Colors.blueAccent,
                        ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: height * 0.15,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),

                                child:Container(
                                      width: 100,
                                      height: 100,
                                      color: Colors.white,
                                      child: CircleAvatar(
                                          child:
                                          (globals.IMAGE_PROFILE!=null)?Image.memory(base64Decode(globals.IMAGE_PROFILE),fit: BoxFit.cover):(globals.IMAGE != null)?Image.memory(base64Decode(globals.IMAGE),fit: BoxFit.cover): Image(
                                            image: AssetImage('./asset/images/shy.gif'),
                                          ),
                                        ),
                                    ),

                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  amount(context, width, height, 0.toString(),
                                      5.toString(), 'VACATION'),
                                  amount(context, width, height, 0.toString(),
                                      5.toString(), 'CASUAL'),
                                  amount(context, width, height, 0.toString(),
                                      30.toString(), 'SICK'),
                                ],
                              ),
                            ]),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8,right: 8,top: 1),
                          child: Container(
                            width: width,
                            margin: EdgeInsets.only(left: 20),
                            height: height*0.05,
                            // color: Colors.amber,
                              child: Text(globals.FIRSTNAME+' '+globals.LASTNAME,
                              style: TextStyle(fontSize: 25,color: Colors.white),),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8,right: 8),
                          child: Container(
                            width: width,
                            margin: EdgeInsets.only(left: 20),
                            height: height*0.1,
                            // color: Colors.amber,
                            child: Text('Position : '+globals.ROLE+'\nEmail : '+globals.EMAIL,
                              maxLines: 2,
                              style: TextStyle(fontSize: 20,color:Colors.white,),),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: height * 0.275),
                    height: height * 0.625,
                    width: width,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/requestLeave');
                          },
                          child: myButton(
                              context, width, height, 'Leave Request',
                              Icons.add_circle_outline_rounded,),
                        ),
                        (globals.STATUS_FACE_REGIS == ResponseCode.FACE_NOT_REGISTER||globals.STATUS_FACE_REGIS == ResponseCode.FACE_REGISTER_DECLINED)
                            ? InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/faceRegis');
                          },
                          child: myButton(context, width, height,
                              'face Register', Icons.face_outlined),
                        ):(globals.STATUS_FACE_REGIS == ResponseCode.FACE_WAITING_REGISTER)?
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/');
                          },
                          child: myButton(context, width, height,
                              'face waiting register', Icons.face_outlined),
                        ):Container(),
                        (globals.STATUS_FACE_REGIS == ResponseCode.FACE_ALREADY_REGISTERED)
                            ? InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/faceUpdate');
                                },
                                child: myButton(context, width, height,
                                    'face update', Icons.face_retouching_natural),
                              )
                            : Container(),
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
