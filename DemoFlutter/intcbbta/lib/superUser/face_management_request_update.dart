import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intcbbta/mockDATA/dataLeaveRequest.dart';
import 'package:intcbbta/model/leave_request_data.dart';

import 'package:intcbbta/global/global.dart'as globals;
import 'package:intcbbta/model/updateFaceStatus.dart';
import 'package:intcbbta/model/userlist.dart';
import 'package:rest_package/bean_admin/face_update_status_request.dart';
import 'package:rest_package/bean_admin/face_update_status_response.dart';
import 'package:rest_package/bean_user/faceExtraction_request.dart';
import 'package:rest_package/bean_user/faceExtraction_response.dart';
import 'package:rest_package/bean_user/face_update_list_request.dart';
import 'package:rest_package/bean_user/face_update_list_response.dart';
import 'package:rest_package/bean_user/face_update_request.dart';
import 'package:rest_package/connection/face_connection.dart';
import 'package:rest_package/connection/user_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
class ApproveFaceUpdate extends StatefulWidget {
  @override
  _ApproveFaceUpdateState createState() => _ApproveFaceUpdateState();
}

class _ApproveFaceUpdateState extends State<ApproveFaceUpdate> {

  XSignature randReqRef = XSignature();
  UserConnection userConnection = UserConnection(globals.IP, globals.PORT);
  FaceExtractionConnection faceConnection =
  FaceExtractionConnection(globals.IP, globals.PORT);
  List<UserModel> _list=[];
  String title = "";
  String description = "";
  String id = '';
  String image ='';
  String request = '';
  var refreshKey = GlobalKey<RefreshIndicatorState>();

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
          });
        }else {
          dialogContentFails(title, description);
        }
      } else {
        dialogContentFails(title, description);
      }
    });
  }

  Future<void> faceRegister(BuildContext context) async {
      String reqRefNo = 'REQ' + randReqRef.generateREQRefNo();
      FaceExtractionRequest request = FaceExtractionRequest(
          userid:id,
          image: image,
          username: null,
          status: null,
          reqRefNo: reqRefNo);
      print("Tokens:"+globals.TOKEN);
      faceConnection.faceExtraction(request,globals.TOKEN).then((value) {
        print('value.status : ' + value.statusCode.toString());
        if (value.statusCode == 200) {
          Map<String, dynamic> responseMap = jsonDecode(value.body);
          FaceExtractionResponse response =
          FaceExtractionResponse.fromJson(responseMap);
          print('reqRefNo : ' + response.reqRefNo);
          print('respCode : ' + response.respCode);
          print('respDesc : ' + response.respDesc);
          title = response.respCode;
          description = response.respDesc;
          if (reqRefNo == response.reqRefNo &&
              response.respCode == ResponseCode.FACE_WAITING_REGISTER) {
            title = "Success";
            dialogContentSuccess(title,description);

          }else{
            dialogContentFails(title, description);
          }
        }
        else{
          dialogContentFails(title, description);
        }
      });
    }

  Future<void> faceDeclined(BuildContext context) async {
    String reqRefNo = 'REQ' + randReqRef.generateREQRefNo();

    FaceUpdateStatusRequest request = FaceUpdateStatusRequest(id, image, ResponseCode.FACE_UPDATE_DECLINED, reqRefNo);
    print("Tokens:"+globals.TOKEN);
    faceConnection.getFaceUpdateDeclined(request).then((value) {
      print('value.status : ' + value.statusCode.toString());
      if (value.statusCode == 200) {
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        FaceUpdateStatusResponse response =
        FaceUpdateStatusResponse.fromJson(responseMap);
        print('reqRefNo : ' + response.reqRefNo);
        print('respCode : ' + response.respCode);
        print('respDesc : ' + response.respDesc);
        title = response.respCode;
        description = response.respDesc;
        if (reqRefNo == response.reqRefNo &&
            response.respCode == ResponseCode.APPROVED) {
          title = "Success";

          dialogContentSuccess(title,description);

        }else{
          dialogContentFails(title, description);
        }
      }
      else{
        dialogContentFails(title, description);
      }
    });
  }


  @override
  void initState() {
    getUpadateRequest(context);
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
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
        Navigator.pushNamed(context, '/viewallstaff');
      },
      child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                  title: Text(
                    'Face Update Management',
                    style: TextStyle(color: Colors.blueAccent, fontSize: height * 0.05),
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
              body:RefreshIndicator(
                key: refreshKey,
                onRefresh: refreshList,
                child: ListView.builder(itemBuilder: (context,index){
                  var item = _list[index];
                  return InkWell(
                    onTap: (){
                      setState(() {
                        globals.ITEM_ID = _list[index].id;
                        globals.ITEM_USERNAME = _list[index].image;
                      });
                      Navigator.pushNamed(context, '/facerequest');
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
              )
          )
      ),
    );
  }
  Widget slideList(String circleAVT, String title, String subtitle,UserModel items, int index) {
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

      //   secondaryActions: <Widget>[
      //     Card(
      //         child:IconSlideAction(
      //           caption: 'Approve',
      //           color: Colors.green,
      //           icon: Icons.approval,
      //           onTap: () {
      //             id = items.id;
      //             image = items.image;
      //             //faceExtraction
      //             dialogContentConfirmApprove();
      //           },
      //         )
      //     ),
      //     Card(
      //       child: IconSlideAction(
      //         caption: 'Decline',
      //         color: Colors.red,
      //         icon: Icons.delete,
      //         onTap: () {
      //           setState(() {
      //             id = items.id;
      //             image = items.image;
      //             //status_extraction
      //             dialogContentConfirmDecline();
      //           });
      //         },
      //       ),
      //     ),
      // ],
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

  Future dialogContentConfirmApprove() {
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize:
                      MainAxisSize.min, // To make the card compact
                      children: <Widget>[
          
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'Confirm to approve',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // To close the dialog
                              },
                              child: Text(
                                "Cancle",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                faceRegister(context);
                                Navigator.of(context).pop();// To close the dialog
                              },
                              child: Text(
                                "Confirm",
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
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

  Future dialogContentConfirmDecline() {
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

                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            'Confirm to decline?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.bottomRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // To close the dialog
                                },
                                child: Text(
                                  "Cancle",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              FlatButton(
                                onPressed: () async {
                                  await faceDeclined(context);
                                  Navigator.of(context).pop();// To close the dialog
                                },
                                child: Text(
                                  "Confirm",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ],
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

}
