import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intcbbta/model/log.dart';

import 'package:rest_package/connection/user_connection.dart';
import 'package:intcbbta/global/global.dart' as globals;
import 'package:rest_package/generator/x_signature.dart';
import 'package:rest_package/bean_admin/visitor_request.dart';
import 'package:rest_package/bean_admin/visitor_response.dart';
import 'package:search_page/search_page.dart';

import 'adminDashboard.dart';

class ViewVisiter extends StatefulWidget {
  @override
  _ViewVisiterState createState() => _ViewVisiterState();
}

class _ViewVisiterState extends State<ViewVisiter> {
  String title = "";
  String description = "";
  XSignature randReqRef = XSignature();
  List<Log> visitorlist = [];
  bool isLoading = false;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    attendance(context);
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      attendance(context);
    });
    return null;
  }
  UserConnection userConnection = UserConnection(globals.IP, globals.PORT);
  Future<void> attendance(BuildContext context) async {
    visitorlist.clear();
    String reqRefNo = 'req' + randReqRef.generateREQRefNo();
    VisitorRequest request = VisitorRequest(reqRefNo);
    userConnection.getVisitor(request, globals.TOKEN).then((value) {
      title = value.statusCode.toString();
      description = value.body.toString();
      print(title);
      print(description);
      if (value.statusCode == 200) {
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        VisitorResponse response = VisitorResponse.fromJson(responseMap);
        for (var e in response.attendance) {
          print(e["rec_id"]);
          (e["role"]=='W')?e["role"]='WHITELIST':(e["role"]=='B')?e["role"]='BLACKLIST':e["role"];
          visitorlist.add(Log(e["rec_id"], e["user_no"], e["username"],
              e["date_time"], e["score"], e["role"]));
        }
        setState(() {
          isLoading=true;
          visitorlist;
        });
      } else {
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
        // Image(image: AssetImage("/asset/images/mis.gif")),
        // Positioned(
        //   left: 16,
        //   right: 16,
        //   child: CircleAvatar(
        //     radius: 65,
        //     backgroundImage: AssetImage("asset/images/mis.gif"),
        //   ),
        // ),
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
          title: Text(
            'Visitor',
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
          }),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () => showSearch(
                  context: context,
                  delegate: SearchPage<Log>(
                      barTheme: ThemeData(primaryColor: Colors.white),
                      searchLabel: 'What are you looking for?',
                      searchStyle: TextStyle(decorationColor: Colors.black),
                      suggestion: Center(
                        child: Container(
                          height: 400,
                          width: 350,

                        ),
                      ),
                      builder: (log) => InkWell(
                        onTap: (){
                          setState(() {
                            globals.ITEM_ID = log.rec_id;
                            globals.ITEM_USERNAME = log.username;
                          });
                          Navigator.pushNamed(context, '/logInfo',arguments:log );
                        },
                        child: ListTile(

                              title: Text(log.user_no + " " + log.username,style: TextStyle(fontSize: 20)),
                              subtitle: Text(
                                  'status :' + log.role + ' score :' + log.score,style: TextStyle(fontSize: 16)),
                              trailing: Text(log.date_time),
                            ),
                      ),
                      filter: (log) => [
                            log.date_time,
                            log.role,
                            log.score,
                            log.user_no,
                            log.username
                          ],
                      items: visitorlist,
                      failure: Center(
                        child: Text("Not Found",style: TextStyle(fontSize: 30),),
                      ))),
            )
          ],
        ),
        body: RefreshIndicator(
          key: refreshKey,
          onRefresh: refreshList,

          child: ListView.builder(
              itemCount: visitorlist.length,
              itemBuilder: (context, index) {
                final Log log = visitorlist[index];
                return isLoading==false??true?CircularProgressIndicator():InkWell(
                  onTap: (){
                    setState(() {
                      globals.ITEM_ID = visitorlist[index].rec_id;
                      globals.ITEM_USERNAME = visitorlist[index].username;
                    });
                    Navigator.pushNamed(context, '/logInfo',arguments:visitorlist[index] );
                  },
                  child: ListTile(
                    title: Text(log.user_no + " " + log.username,style: TextStyle(fontSize: 20)),
                    //'Position:' + log.role +
                    subtitle: Text( ' score:' + log.score,style: TextStyle(fontSize: 18)),
                    trailing: Text(log.date_time),
                  ),
                );
              }),
        ),
      )),
    );
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
