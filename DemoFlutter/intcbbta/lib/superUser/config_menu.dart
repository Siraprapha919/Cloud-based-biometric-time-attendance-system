import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rest_package/bean_user/config_request.dart';
import 'package:rest_package/bean_user/config_response.dart';
import 'package:rest_package/connection/face_connection.dart';
import 'package:intcbbta/global/global.dart' as globals;
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';

class ConfigMenu extends StatefulWidget {
  @override
  _ConfigMenuState createState() => _ConfigMenuState();
}

class _ConfigMenuState extends State<ConfigMenu> {
  bool time_start = false;
  bool time_before = false;
  bool time_ends = false;
  bool score_validate = false;
  bool vday = false;
  bool sday = false;
  bool cday = false;
  bool edit = false;
  var timeStart = TextEditingController();
  var timeBefore = TextEditingController();
  var timeEnds = TextEditingController();
  var score = TextEditingController();
  var vacation = TextEditingController();
  var sick = TextEditingController();
  var casual = TextEditingController();
  DateTime timeStartss = null;

  DateTime timeBeforess = null;
  DateTime timeEndsss  = null;
  String title, description= null;
  String setTime;
  String hour, minute, time;
  DateTime selectTime;
  final _formKey = GlobalKey<FormState>();
  TextEditingController timeController = TextEditingController();
  FaceExtractionConnection connection =
      FaceExtractionConnection(globals.IP, globals.PORT);
  String reqRefNo = 'req' + XSignature().generateREQRefNo();
  String validateRequired(String val, String fieldname) {
    return (val == null || val == '') ? '$fieldname is Required' : null;
  }

  Future<void> config(BuildContext context) async {
    ConfigRequest request = ConfigRequest(
        score.text,
        timeStart.text,
        timeBefore.text,
        timeEnds.text,
        vacation.text,
        casual.text,
        sick.text,
        globals.EMPLOYEE_NO,
        globals.FIRSTNAME,
        globals.ROLE,
        reqRefNo);
    connection.config(request, globals.TOKEN).then((value) {
      title = value.statusCode.toString();
      description = value.body;
      if (value.statusCode == 200) {
        Map<String, dynamic> responseMap = jsonDecode(value.body);
        ConfigResponse response = ConfigResponse.fromJson(responseMap);
        print(response.respDesc);
        if (response.reqRefNo == reqRefNo) {
          if (response.respCode == ResponseCode.APPROVED) {
            title = 'success';
            description = '';
            dialogContentSuccess(title, description);
          } else {
            dialogContentFails(title, description);
          }
        }
      } else {
        dialogContentFails(title, description);
      }
    });
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
            title: Text(
              'CONFIG',
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
                    Navigator.pushNamed(context, '/adminDashboard');
                  });
            }),
            actions: <Widget>[
              (edit == false)
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
                        // print("timestart:"+timeStart.text);
                        // print("timebefore:"+timeBefore.text);
                        // print("timeends:"+timeEnds.text);
                        // print("timestartss:"+timeStartss.isAfter(timeBeforess).toString());
                        // print("timebeforess:"+timeBeforess.isAfter(timeEndsss).toString());
                        // print("timeendsss:"+timeEndsss.isAfter(timeStartss).toString());
                        if (_formKey.currentState.validate()) {
                            config(context);
                          // if (DateTime.parse(timeStart.text).isBefore(DateTime.parse(timeBefore.text)) &&
                          //     DateTime.parse(timeBefore.text).isBefore(DateTime.parse(timeEnds.text))) {
                          //   config(context);
                          //   setState(() {
                          //     edit = false;
                          //   });
                          // } else {
                          //   dialogContentFails('invalid time',
                          //       'please select time start < time before < time ends');
                          // }
                        }
                      },
                      child: Text(
                        'SAVE',
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 20),
                      ))
            ],
          ),
          body: Form(
            key: _formKey,
            child: Container(
              width: width,
              height: height,
              color: Colors.white,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 25),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Time',
                          style: TextStyle(
                              color: Colors.blueAccent, fontSize: 50),
                        )),
                  ),
                  _textFieldTime(timeStart, 'time start',timeStartss),
                  _textFieldTime(
                      timeBefore, 'time before late',timeBeforess),
                  _textFieldTime(timeEnds, 'time ends',timeEndsss),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Score',
                          style: TextStyle(
                              color: Colors.blueAccent, fontSize: 50),
                        )),
                  ),
                  _textField(score, 'score', score_validate),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Leave Day',
                          style: TextStyle(
                              color: Colors.blueAccent, fontSize: 50),
                        )),
                  ),
                  _textField(casual, 'casual', cday),
                  _textField(vacation, 'vacation', vday),
                  _textField(sick, 'sick', sday),
                ],
              ),
            ),
          ),
        )));
  }

  Widget _textField(
      TextEditingController controller, String labelText, bool validate) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 10, left: 25, right: 50, bottom: 10),
      child: TextFormField(
          enabled: edit,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(),
            focusColor: Colors.blueAccent,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          ),
          onSaved: (value) {
            controller.text = value;
          },
          controller: controller,
          autovalidate: validate,
          onChanged: (bool) {
            setState(() {
              return validate = true;
            });
          },
          validator: (value) {
            if (value == null || value == "") {
              return validateRequired(value, labelText);
            }
          }),
    );
  }

  Widget _textFieldTime(TextEditingController retrieve, String labelText,DateTime time) {
    final format = DateFormat.Hm();
    return Padding(
      padding:
          const EdgeInsets.only(top: 10, left: 25, right: 50, bottom: 10),
      child: DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final TimeOfDay time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return time == null ? null : DateTimeField.convert(time);
        },

        enabled: edit,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.access_time_outlined),
          labelText: labelText,
          border: OutlineInputBorder(),
          focusColor: Colors.blueAccent,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (date) => date == null ? 'Invalid date' : null,
        controller: retrieve,
        onChanged: (date) {
          setState(() {
            time = date;
            retrieve;
            print("onChanged:"+date.toString());
            print("retrieve:"+retrieve.toString());
          });
        },
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
                      image: AssetImage('./asset/images/wink.gif'),
                      width: 175,
                      height: 175),
                ),
              ],
            )));
  }
}
