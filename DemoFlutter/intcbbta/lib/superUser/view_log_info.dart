import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intcbbta/model/log.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:rest_package/bean_user/info_visitor_request.dart';
import 'package:rest_package/bean_user/info_visitor_response.dart';
import 'package:rest_package/connection/face_connection.dart';
import 'package:intcbbta/global/global.dart' as globals;

class LogInfo extends StatefulWidget {
  @override
  _LogInfoState createState() => _LogInfoState();
}

class _LogInfoState extends State<LogInfo> {
  bool isLoading = false;
  String image = "";
  XSignature randReqRef = XSignature();
  Image imageFile;

  FaceExtractionConnection connection =
      FaceExtractionConnection(globals.IP, globals.PORT);

  Future<void> viewInfo(BuildContext context) async {
    image = '';
    String reqRefNo = 'req' + randReqRef.generateREQRefNo();
    print('globals.ITEM_ID:' + globals.ITEM_ID.toString());
    InfoVisitorRequest request =
        InfoVisitorRequest(globals.ITEM_ID, globals.ITEM_USERNAME, reqRefNo);
    connection.imageVisitor(request, globals.TOKEN).then((value) {
      print(value.body);
      if (value.statusCode == 200) {
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        InfoVisitorResponse response =
            InfoVisitorResponse.fromJson(responseMap);
        setState(() {
          image = response.image;
          isLoading = false;
          imageFile = Image.memory(base64Decode(image));
        });
      }
    });
  }

  // @override
  // void initState() {}

  @override
  void initState() {
    viewInfo(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    if (globals.ITEM_USERNAME != null || globals.ITEM_ID != null) {
      globals.ITEM_USERNAME = null;
      globals.ITEM_ID = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    Log logInfo = ModalRoute.of(context).settings.arguments;
    print('user_no:' + logInfo.user_no);
    return Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 4,
            child: Container(
              width: width,
              height: height * 0.45,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0)
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                child: imageFile == null || imageFile == ""
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Image.memory(
                        base64Decode(image),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          _textField(logInfo.user_no,'ID'),
          _textField(logInfo.username,'Name'),
          _textField(logInfo.score,'Score'),
          _textField(DateTime.parse(logInfo.date_time).toString(),'Date-Time'),
          _textField(logInfo.role=='W'||logInfo.role=='WHITELIST'?logInfo.role='WHITELIST':(logInfo.role=='UNKNOWN')?logInfo.role:logInfo.role='BLACKLIST','Accessibility'),
        ],
      ),
    );
  }

  Widget _textField(
    String value,
    String labelText,
  ) {
    TextEditingController controller = TextEditingController(text: value);
    return Flexible(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.only(top: 10,left: 20,right: 20),
        child: Card(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(fontSize: 30,color: Colors.black),
              border: OutlineInputBorder(),
              focusColor: Colors.blueAccent,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: EdgeInsets.symmetric(horizontal: 30,vertical:15 ),
            ),
            controller: controller,
            style: TextStyle(fontSize: 20,color: Colors.blueAccent),
            enabled: false,
          ),
        ),
      ),
    );
  }
}
/*Container(
        width: width,
        height: height,
        child: Column(
          children: <Widget>[
            imageFile==null||imageFile=="" ? Center(child: CircularProgressIndicator(),)
                :imageFile,
            Text('username:' +
                logInfo.user_no +
                '\n' +
                logInfo.username +
                '\n' +
                logInfo.role +
                '\n' +
                logInfo.score +
                '\n' +
                logInfo.date_time)
          ],
        ),
      ),*/
