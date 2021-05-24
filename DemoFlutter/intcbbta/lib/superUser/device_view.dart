import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intcbbta/model/device_all.dart';
import 'package:intcbbta/superUser/device_register.dart';
import 'package:rest_package/connection/device_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:intcbbta/global/global.dart' as globals;
import 'package:rest_package/bean_admin/deviceAll_request.dart';
import 'package:rest_package/bean_admin/deviceAll_response.dart';
import 'package:rest_package/bean_admin/device_delete_request.dart';
import 'package:rest_package/bean_admin/device_delete_response.dart';

class Device extends StatefulWidget {
  @override
  _DeviceState createState() => _DeviceState();
}

class _DeviceState extends State<Device> {
  XSignature randReqRef = XSignature();
  DeviceConnection connection = DeviceConnection(globals.IP,globals.PORT);
  List<DeviceAll> devicesAll = [];
  String title = "";
  String description ="";
  
  @override
  void initState() {
    getDeviceAll(context);
  }
  Future<void> getDeviceAll(BuildContext context) {
    String reqRefNo = 'req' + randReqRef.generateREQRefNo();
    DeviceAllRequest request = DeviceAllRequest(reqRefNo);
    connection.deviceAll(request, globals.TOKEN).then((value) {
      print("Response Code:" + value.statusCode.toString());
      if (value.statusCode == 200) {
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        DeviceAllResponse getDeviceResponse  =  DeviceAllResponse.fromJson(responseMap);
        for (var n in getDeviceResponse.deviceAll) {
          devicesAll.add(DeviceAll(n["rec_id"],n["msCategory"], n["code"], n["name"]));
        }
        setState(() {
          devicesAll;
        });
      }
    });
  }

  Future<void> delete(BuildContext context,String deviceCode) {
    String reqRefNo = 'req' + randReqRef.generateREQRefNo();
    DeviceDeleteRequest request = DeviceDeleteRequest(deviceCode,globals.ADMIN_USERNAME,reqRefNo);
    connection.deviceDelete(request, globals.TOKEN).then((value) {
      print("Response Code:" + value.statusCode.toString());
      if (value.statusCode == 200) {
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        DeviceDeleteResponse response  =  DeviceDeleteResponse.fromJson(responseMap);
        if(response.reqRefNo==reqRefNo&&response.respCode==ResponseCode.APPROVED){
            devicesAll.clear();
            getDeviceAll(context);
        }
        else{
          showDialog(
            context: context,
            builder: (BuildContext context) => Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                child: dialogContent(title, description)),
          );
        }
      }
    });
  }

  Widget dialogContent(String title, String desc) {
    return Stack(
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
              mainAxisSize: MainAxisSize.min, // To make the card compact
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

        // Image.asset("/asset/images/mis.gif"),
        // Image(image: AssetImage("/asset/images/mis.gif"))
        // Positioned(
        //   left: 16,
        //   right: 16,
        //   child: CircleAvatar(
        //     radius: 65,
        //     backgroundImage:AssetImage("asset/images/mis.gif"),
        //   ),
        // ),
      ],
    );
  }

  Widget slideList(String circleAVT,String title,String subtitle,String sub,DeviceAll items){
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.white,
          child: InkWell(
            onTap: () {
              // Navigator.pushNamed(context, "/detailDevice",arguments: items);
              },
            child: Card(
              child: ListTile(
                // leading:
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(10),
                //
                //   child: Text('tt'),
                // ),
                title: Text(title),
                subtitle: Text(subtitle+" "+sub),
              ),
            ),
          ),
        ),
      ),
      secondaryActions: <Widget>[
        ////////devicedetail
        // Card(
        //   child:IconSlideAction(
        //     caption: 'info',
        //     color: Colors.black45,
        //     icon: Icons.more_horiz,
        //     onTap: () { Navigator.pushNamed(context, "/detailDevice");},
        //   ),),
        Card(
            child:IconSlideAction(
              caption: 'edit',
              color: Colors.green,
              icon: Icons.edit,
              onTap: () {
                Navigator.pushNamed(context, "/deviceUpdate",arguments: items);
              },
            )),

        Card(
          child: IconSlideAction(
            caption: 'delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              delete(context,subtitle);
            },
          ),
        ),
      ],
    );
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
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.add_box_outlined,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/createDevice");
                  })
            ],
            title: Text(
              'Device',
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
          Navigator.pushNamed(context, '/adminDashboard');
          });
          })),
        body: ListView.builder(
            itemBuilder: (context,index){
          var item = devicesAll[index];
          return slideList("D"+index.toString(),item.name,item.code,item.msCategory,item);
        },
            itemCount: devicesAll.length)
      )),
    );
  }
}
