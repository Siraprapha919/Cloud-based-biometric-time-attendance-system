import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intcbbta/model/updateFaceStatus.dart';
import 'package:intcbbta/model/userlist.dart';
import 'package:rest_package/bean_admin/face_black_white_request.dart';
import 'package:rest_package/bean_admin/face_black_white_response.dart';
import 'package:rest_package/bean_admin/face_update_status_request.dart';
import 'package:rest_package/bean_admin/face_update_status_response.dart';
import 'package:rest_package/bean_admin/get_face_request.dart';
import 'package:rest_package/bean_admin/get_face_response.dart';
import 'package:rest_package/bean_user/faceExtraction_request.dart';
import 'package:rest_package/bean_user/faceExtraction_response.dart';
import 'package:rest_package/bean_user/face_update_list_request.dart';
import 'package:rest_package/bean_user/face_update_list_response.dart';
import 'package:rest_package/bean_user/face_update_response.dart';
import 'package:rest_package/bean_user/user_info_request.dart';
import 'package:rest_package/connection/face_connection.dart';
import 'package:rest_package/connection/user_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:intcbbta/global/global.dart'as globals;
class ViewAllStaff extends StatefulWidget {
  @override
  _ViewAllStaffState createState() => _ViewAllStaffState();
}

class _ViewAllStaffState extends State<ViewAllStaff> {
  XSignature randReqRef = XSignature();
  UserConnection userConnection = UserConnection(globals.IP, globals.PORT);
  FaceExtractionConnection faceConnection =
  FaceExtractionConnection(globals.IP, globals.PORT);
  bool isloading = false;
  List<UserModel> _list=[];
  List<UserModel> _listAmountRequest=[];
  //_list
  String title = "";
  String description = "";
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    getFace(context);
    getUpadateRequest(context);
  }
  Future<void> deleteUser(BuildContext context,String id,String mobileNo){
    String reqRefNo = 'req' + randReqRef.generateREQRefNo();
    UserInfoRequest request = UserInfoRequest(id, mobileNo, reqRefNo);
    userConnection.deleteUser(request, globals.TOKEN).then((value) {
      title = value.statusCode.toString();
      description = value.body.toString();
      print(title);
      print(description);
      if (value.statusCode == 200) {
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        FaceUpdateResponse response =
        FaceUpdateResponse.fromJson(responseMap);
        if (reqRefNo == response.reqRefNo && response.respCode == ResponseCode.APPROVED) {
          dialogContentSuccess('Success', '');
          getFace(context);
        }else if(reqRefNo == response.reqRefNo && response.respCode == ResponseCode.DECLINED){
          title='Request declined';
          dialogContentFails(title, '');
        }
      } else {
        dialogContentFails(title, description);
      }

    });
  }
  Future<void> updateFaceStatus(BuildContext context, UpdateFaceStatus update) {
    _list.clear();
    String reqRefNo = 'req' + randReqRef.generateREQRefNo();
    FaceBlackWhiteRequest request =
    FaceBlackWhiteRequest(update.id, update.status, reqRefNo);
    faceConnection.blackwhite(request, globals.TOKEN).then((value) {
      title = value.statusCode.toString();
      description = value.body.toString();
      print(title);
      print(description);
      if (value.statusCode == 200) {
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        FaceBlackWhiteResponse response =
        FaceBlackWhiteResponse.fromJson(responseMap);
        if (reqRefNo == response.reqRefNo && response.respCode == ResponseCode.APPROVED) {
          dialogContentSuccess('Success', '');
          getFace(context);
        }else {
          dialogContentFails(title, description);
        }
      } else {
        dialogContentFails(title, description);
      }
    });
  }

  Future<void> getFace(BuildContext context) {
    _list.clear();
    String reqRefNo = 'req' + randReqRef.generateREQRefNo();
    GetFaceRequest request = GetFaceRequest(reqRefNo);
    userConnection.getFace(request, globals.TOKEN).then((value) {
      print("Response Code:" + value.statusCode.toString());
      print(value.body);
      if (value.statusCode == 200) {
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        GetFaceResponse getFaceResponse = GetFaceResponse.fromJson(responseMap);
        for (var n in getFaceResponse.model) {
          (n["accessibility"]==ResponseCode.WHITELIST)?n["accessibility"]='WHITELIST':n["accessibility"]='BLACKLIST';
          _list.add(UserModel(
            n["id"],
            n["name"],
            n["lastname"],
            n["image"],
            n["accessibility"],
          ));
        }
        setState(() {
          _list;
          isloading =true;
        });
        for (UserModel e in _list) {
          print('name:'+e.name);
        }
      }
    });
  }

  Future<void> getUpadateRequest(BuildContext context) {
    _list.clear();
    String reqRefNo = 'req' + randReqRef.generateREQRefNo();
    FaceUpdateListRequest request = FaceUpdateListRequest(reqRefNo);
    faceConnection.getFaceUpdate(request, globals.TOKEN).then((value) {
      title = value.statusCode.toString();
      description = value.body.toString();
      print(title);
      print(description);
      if (value.statusCode == 200) {
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        FaceUpdateListResponse response =
        FaceUpdateListResponse.fromJson(responseMap);
        if (reqRefNo == response.reqRefNo && response.respCode == ResponseCode.APPROVED) {
          for(var n in response.model){
            _listAmountRequest.add(UserModel(
              n["id"],
              n["name"],
              n["lastname"],
              n["image"],
              n["accessibility"],
            ));
          }
          setState(() {
            _listAmountRequest;
          });
        }else {
          dialogContentFails(title, description);
        }
      } else {
        dialogContentFails(title, description);
      }
    });
  }

  Widget slideList(String circleAVT, String title, String subtitle,
      UserModel items, int index) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          child: Card(
            color: (_list[index].accessibility == 'BLACKLIST')?Colors.black:Colors.white,
            child: ListTile(
              leading: (items.image != null)
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.memory(base64Decode(items.image)),
              )
                  : CircleAvatar(
                child: Text(items.name[0] + items.lastname[0]),
              ),
              title: Text(
                title,
                style: TextStyle(color: (_list[index].accessibility == 'BLACKLIST')?Colors.white:Colors.black),
              ),
              subtitle: Text(
                subtitle,
                style: TextStyle(color: (_list[index].accessibility == 'BLACKLIST')?Colors.white:Colors.black),
              ),
            ),
          ),
        ),
      ),
      actions: [
        (_list[index].image != null)?(_list[index].accessibility == 'BLACKLIST')?Card(
          child: IconSlideAction(
            caption: 'Un-Block',
            color: Colors.white,
            icon: Icons.accessibility_new,
            onTap: () {
              setState(() {
                _list[index].accessibility = ResponseCode.WHITELIST;
                UpdateFaceStatus items = UpdateFaceStatus(
                    _list[index].id,
                    _list[index].accessibility);
                updateFaceStatus(context, items);
              });
            },
          ),
        ):Card(
          child: IconSlideAction(
            caption: 'Block',
            color: Colors.black,
            icon: Icons.block,
            onTap: () {
              setState(() {
                _list[index].accessibility = ResponseCode.BLACKLIST;
                UpdateFaceStatus items = UpdateFaceStatus(
                    _list[index].id,
                    _list[index].accessibility);
                updateFaceStatus(context, items);
              });
            },
          ),
        ):Text('Face not register'),
      ],
      secondaryActions: <Widget>[
        Card(
            child:IconSlideAction(
              caption: 'edit',
              color: Colors.green,
              icon: Icons.edit,
              onTap: () {
                setState(() {
                  globals.ITEM_ID = _list[index].id;
                  globals.ITEM_USERNAME = _list[index].image;
                });
                Navigator.pushNamed(context, '/editUser');
              },
            )),

        Card(
          child: IconSlideAction(
            caption: 'delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              deleteUser(context,items.id,"");
              // delete(context,subtitle);
            },
          ),
        ),
      ],
    );
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      getFace(context);
      getUpadateRequest(context);
    });
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
                    'USER',
                    style: TextStyle(
                        color: Colors.blueAccent, fontSize: height * 0.05),
                  ),
                  elevation: 0.0,
                  backgroundColor: Colors.white,
                  actions: <Widget>[

                    (_listAmountRequest.length!=0)?IconButton(icon: Icon(Icons.notifications_active_outlined,color: Colors.blueAccent,), onPressed: (){
                      Navigator.pushNamed(context, '/request_update');
                    }):Container(),
                    IconButton(color: Colors.blueAccent,
                      onPressed: (){

                   Navigator.pushNamed(context, '/RegisterByAdmin');
                  },icon: Icon(Icons.add_circle_outline),)],
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
              body: RefreshIndicator(
                key: refreshKey,
                onRefresh: refreshList,
                child:!isloading?Center(child: CircularProgressIndicator()):Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemBuilder: (context, index) {
                        var item = _list[index];
                        print('access:'+item.accessibility.toString());
                        return InkWell(
                          onTap: (){
                            setState(() {
                              globals.ITEM_ID = _list[index].id;
                              globals.ITEM_USERNAME = _list[index].image;
                            });
                            Navigator.pushNamed(context, '/editUser');
                          },
                          child: slideList(
                              item.name[0] + item.lastname[0],
                              item.name + " " + item.lastname,
                              item.accessibility,
                              item,
                              index),
                        );
                      },
                      itemCount: _list.length),
                ),
              ))),
    );
  }

  Future dialogContentSuccess(String title, String desc) {
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
