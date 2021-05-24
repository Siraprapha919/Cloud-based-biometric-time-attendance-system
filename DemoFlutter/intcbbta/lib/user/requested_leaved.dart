import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/icons.dart';
import 'package:flutter/src/painting/alignment.dart';
import 'package:intl/intl.dart';
import 'package:rest_package/bean_user/leaveReq_request.dart';
import 'package:rest_package/connection/user_connection.dart';
import 'package:rest_package/constant/response_code.dart';
import 'package:rest_package/generator/x_signature.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intcbbta/global/global.dart' as globals;
// import 'material_localizations.dart';

class RequestedLeave extends StatefulWidget {
  @override
  _RequestedLeaveState createState() => _RequestedLeaveState();
}

class _RequestedLeaveState extends State<RequestedLeave> {
  TextEditingController _leaveTypeController = TextEditingController();
  var _pickerController = DateRangePickerController();
  int days = 0;
  DateTime rangeStartDate;
  DateTime rangeEndDate;
  DateTime selectedDate;
  List<DateTime> selectedDates = [];
  List<DateTime> weekend = [];
  Color sickColor;
  Color vacationColor;
  Color casualColor;
  String leaveType = "";
  int daysSick = 0;
  int daysVacation = 0;
  int daysCasual = 0;
  final sick = 30;
  final vacation = 5;
  final casual = 5;
  List<DateTime> listDate = [];
  List<DateTime> isSelectChanged = [];
  UserConnection userConnection = new UserConnection(globals.IP, globals.PORT);
  bool _autovalidate = false;
  final _formKey = GlobalKey<FormState>();
  List<bool> isSelected = [false, false, false];
  List<String> leaveList = ["vacation", "casual", "sick"];
  Future<void> leave(BuildContext context) async {
    XSignature randReqRef = XSignature();
    String reqRefNo = 'req' + randReqRef.generateREQRefNo();
    LeaveRequest leaveRequest =
    LeaveRequest(globals.EMPLOYEE_NO,globals.FIRSTNAME,globals.LASTNAME,selectedDates,leaveType,selectedDates.length.toString(),reqRefNo);

  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    Widget _Container(Widget widget) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.blueAccent),
            ),
            width: width * 0.9 / 2.5,
            height: height * 0.07,
            child: widget),
      );
    }
    void listenType() {
      if (selectedDates.isEmpty) {
        daysSick = 0;
        daysVacation = 0;
        daysCasual = 0;
      }
      (leaveType != "sick")
          ? setState(() {
              daysSick = 0;
              sickColor = Colors.black;
            })
          : setState(() {
              daysSick = days;
            });
      (leaveType != "casual")
          ? setState(() {
              daysCasual = 0;
              casualColor = Colors.black;
            })
          : setState(() {
              daysCasual = days;
            });
      (leaveType != "vacation")
          ? setState(() {
              daysVacation = 0;
              vacationColor = Colors.black;
            })
          : setState(() {
              daysVacation = days;
            });
      if (selectedDates != null) {
        switch (leaveType) {
          case "sick":
            {
              (daysSick > 30)
                  ? setState(() {
                      sickColor = Colors.red;
                    })
                  : setState(() {
                      sickColor = Colors.blueAccent;
                    });
              (daysSick <= 30)
                  ? setState(() {
                      sickColor = Colors.blueAccent;
                    })
                  : setState(() {
                      sickColor = Colors.red;
                    });
              break;
            }
          case "casual":
            {
              daysCasual = days;
              (daysCasual > 5)
                  ? setState(() {
                      casualColor = Colors.red;
                    })
                  : setState(() {
                      casualColor = Colors.blueAccent;
                    });
              (daysCasual <= 5)
                  ? setState(() {
                      casualColor = Colors.blueAccent;
                    })
                  : setState(() {
                      casualColor = Colors.red;
                    });
              break;
            }
          case "vacation":
            {
              daysVacation = days;
              (daysVacation > 5)
                  ? setState(() {
                      vacationColor = Colors.red;
                    })
                  : setState(() {
                      vacationColor = Colors.blueAccent;
                    });
              (daysVacation <= 5)
                  ? setState(() {
                      vacationColor = Colors.blueAccent;
                    })
                  : setState(() {
                      vacationColor = Colors.red;
                    });

              break;
            }
        }
      }
    }

    void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
      if (args.value is List<DateTime>) {
        setState(() {
          print("args.value:" + args.value.toString());
          selectedDates = args.value;
          selectedDates.sort();
          rangeStartDate = selectedDates.first;
          rangeEndDate = selectedDates.last;
          isSelectChanged = args.value;
        });
        selectedDates == null ? days = 0 : days = selectedDates.length;
        listenType();
      }
    }

    Widget _DropFormField(
      String _value,
      String _hint,
    ) {
      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: DropdownButtonFormField(
            decoration: InputDecoration(
              focusColor: Colors.blueAccent,
              // border: OutlineInputBorder(),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              enabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            ),
            hint: Text(_hint),
            items: ['casual', 'vacation', 'sick']
                .map<DropdownMenuItem<String>>((String _value) {
              return DropdownMenuItem(value: _value, child: Text(_value));
            }).toList(),
            autovalidate: _autovalidate,
            onChanged: (_leave) => setState(() {
                  leaveType = _leave;
                  print("leaveRequest:" + leaveType);
                  listenType();
                }),
            validator: (value) => value == null ? '$_hint required' : null),
      );
    }

    amount(BuildContext context, double width, double height, int amount,
        int total, String type, Color customColor) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Card(
          shadowColor: Colors.blue,
          elevation: 4,
          child: Container(
            height: height * 0.1,
            width: width * 0.26,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '$amount' + '/' + '$total',
                  style: TextStyle(fontSize: height * 0.04, color: customColor),
                  textAlign: TextAlign.center,
                ),
                Text(
                  type,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: height * 0.0223,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: WillPopScope(
        onWillPop: (){
          Navigator.pushNamed(context, '/adminDashboard');
        },
        child: Scaffold(
          appBar: AppBar(
              title: Text(
                'Create Request',
                style:
                    TextStyle(color: Colors.blueAccent, fontSize: height * 0.05),
              ),
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
          body: Container(
            color: Colors.white,
            width: width,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: width * 0.90,
                  height: height * 0.35,
                  // color: Colors.red,
                  child: SfDateRangePicker(
                    selectionMode: DateRangePickerSelectionMode.multiple,
                    toggleDaySelection: true,
                    allowViewNavigation: true,
                    selectionTextStyle: const TextStyle(color: Colors.white),
                    selectionColor: Colors.blue,
                    rangeTextStyle:
                        const TextStyle(color: Colors.white, fontSize: 12),
                    view: DateRangePickerView.month,
                    monthViewSettings: DateRangePickerMonthViewSettings(
                      weekendDays: List<int>()..add(7)..add(6),
                      showTrailingAndLeadingDates: true,
                      enableSwipeSelection: true,
                    ),
                    enablePastDates: false,
                    monthCellStyle: DateRangePickerMonthCellStyle(
                        weekendTextStyle: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                            color: Colors.red)),
                    onSelectionChanged: _onSelectionChanged,
                  ),
                ),
                Container(
                  height: height - (height * 0.55),
                  decoration: BoxDecoration(
                      // color: Colors.blueAccent,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Column(
                    children: [
                      ToggleButtons(
                          isSelected: isSelected,
                          // selectedColor: Colors.blueAccent,
                          // color: Colors.black,
                          renderBorder: false,
                          // borderRadius: BorderRadius.all(Radius.circular(10)),
                          // disabledColor: Colors.black12,
                          fillColor: Colors.transparent,
                          // focusColor: Colors.blueAccent,
                          // hoverColor: Colors.blueAccent,
                          children: [
                            amount(context, width, height, daysVacation, vacation,
                                'VACATION', vacationColor),
                            amount(context, width, height, daysCasual, casual,
                                'CASUAL', casualColor),
                            amount(context, width, height, daysSick, sick, 'SICK',
                                sickColor),
                          ],
                          selectedBorderColor: Colors.blueAccent,
                          borderColor: Colors.blueAccent,
                          onPressed: (int newIndex) {
                            setState(() {
                              for (int index = 0;
                                  index < isSelected.length;
                                  index++) {
                                if (index == newIndex) {
                                  isSelected[index] = !isSelected[index];
                                } else {
                                  isSelected[index] = false;
                                }
                              }
                              leaveType = leaveList[newIndex];
                              print("leaveType:" + leaveType);
                              selectedDates != null ? listenType() : null;
                              // print("leaveType:" + leaveType);
                            });
                          }),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        'Date From',
                                        style: TextStyle(
                                            fontSize: height * 0.03,
                                            color: Colors.blueAccent),
                                      ),
                                    ),
                                    _Container(Center(
                                      child: (rangeStartDate != null)
                                          ? Text(DateFormat.yMMMd()
                                              .format(rangeStartDate))
                                          : Text(''),
                                    )),
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      child: Text(
                                        'Date To',
                                        style: TextStyle(
                                            fontSize: height * 0.03,
                                            color: Colors.blueAccent),
                                      ),
                                    ),
                                    _Container(Center(
                                      //DateFormat.yMMMd().format(rangeEndDate)
                                      child: (rangeEndDate != null)
                                          ? Text(DateFormat.yMMMd()
                                              .format(rangeEndDate))
                                          : Text(''),
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          bool check = false;
                          setState(() {
                            isSelected.forEach((element) {
                              if (element == true) {
                                return check = true;
                              }
                            });
                            if (check == true && days != 0) {
                              switch (leaveType) {
                                case "vacation":
                                  (daysVacation > 5 && daysVacation != 0)
                                      ? null
                                      : leave(context);
                                  break;
                                case "sick":
                                  (daysSick > 30 && daysSick != 0)
                                      ? null
                                      : leave(context);
                                  break;
                                case "casual":
                                  (daysCasual > 5 && daysCasual != 0)
                                      ? null
                                      : leave(context);
                                  break;
                              }
                            }
                          });
                          print("check:" + check.toString());
                          print(selectedDates);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            //  color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          alignment: Alignment.center,
                          width: width * 0.25,
                          height: height * 0.065,
                          child: Text(
                            'SUBMIT',
                            style: TextStyle(
                                fontSize: height * 0.025,
                                color: Colors.blueAccent),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
