import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intcbbta/model/updateFaceStatus.dart';
import 'package:intcbbta/model/userlist.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:rest_package/bean_admin/get_face_request.dart';
import 'package:rest_package/bean_admin/get_face_response.dart';
import 'package:rest_package/connection/user_connection.dart';
import 'package:intcbbta/global/global.dart' as globals;
import 'package:rest_package/bean_admin/face_black_white_request.dart';
import 'package:rest_package/bean_admin/face_black_white_response.dart';
import 'package:rest_package/connection/face_connection.dart';

class ViewAccesslist extends StatefulWidget {
  @override
  _ViewAccesslistState createState() => _ViewAccesslistState();
}

class _ViewAccesslistState extends State<ViewAccesslist> {
  XSignature randReqRef = XSignature();
  UserConnection userConnection = UserConnection(globals.IP, globals.PORT);
  FaceExtractionConnection faceConnection =
      FaceExtractionConnection(globals.IP, globals.PORT);
  List<UserModel> _list=[];
  String title = "";
  String description = "";
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  bool isloading = false;
  @override
  void initState() {
    getFace(context);
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
          isloading = true;
        });
        for (UserModel e in _list) {
          print('name:'+e.name);
        }
      }
    });
  }

  Widget slideWhiteList(String circleAVT, String title, String subtitle,
      UserModel items, int index) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.white,
          child: Card(
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
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                subtitle,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
      secondaryActions: <Widget>[
        (_list[index].image != null)?Card(
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
        ):null,
      ],
    );
  }
  Widget cardPennding(String circleAVT, String title, String subtitle,
          UserModel items, int index) =>
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          // color: Colors.black,
          child: Card(
            color: Colors.black45,
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: (items.image != null)
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.memory(base64Decode(items.image)),
                      )
                    : CircleAvatar(
                        child: Text(items.name[0] + items.lastname[0]),
                      ),
              ),
              title: Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                subtitle,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      );
  Widget slideBlackList(String circleAVT, String title, String subtitle,
      UserModel items, int index) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          // color: Colors.black,
          child: Card(
            color: Colors.black,
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
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                subtitle,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      secondaryActions: <Widget>[
        (_list[index].image != null)?Card(
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
        ):null,
      ],
    );
  }
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      getFace(context);
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamed(context, '/face_manage');
      },
      child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                  title: Text(
                    'Face Access',
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
                          Navigator.pushNamed(context, '/face_manage');
                        });
                  })),
              body: RefreshIndicator(
                key: refreshKey,
                onRefresh: refreshList,
                child: !isloading?Center(child: CircularProgressIndicator()):ListView.builder(
                    itemBuilder: (context, index) {
                      var item = _list[index];
                      print('access:'+item.accessibility.toString());
                      switch (item.accessibility) {
                        case 'WHITELIST':
                          {
                            return slideWhiteList(
                                item.name[0] + item.lastname[0],
                                item.name + " " + item.lastname,
                                item.accessibility,
                                item,
                                index);
                          }
                        case 'BLACKLIST':
                          {
                            return slideBlackList(
                                item.name[0] + item.lastname[0],
                                item.name + " " + item.lastname,
                                item.accessibility,
                                item,
                                index);
                          }
                        default:
                          return cardPennding(
                              item.name[0] + item.lastname[0],
                              item.name + " " + item.lastname,
                              item.accessibility,
                              item,
                              index);
                      }
                    },
                    itemCount: _list.length),
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
