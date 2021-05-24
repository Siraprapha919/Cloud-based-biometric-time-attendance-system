import 'package:flutter/material.dart';
import 'package:intcbbta/mockDATA/dataLeaveRequest.dart';
import 'package:intcbbta/model/leave_request_data.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DetailRequest extends StatefulWidget {
  // LeaveRequest leaveRequest;
  @override
  _DetailRequestState createState() => _DetailRequestState();
  // DetailRequest({Key key,this.leaveRequest}):super(key:key);
}

class _DetailRequestState extends State<DetailRequest> {
  int days;
  DateTime rangeStartDate;
  DateTime rangeEndDate;
  DateTime selectedDate;
  List<DateTime> selectedDates; //blackout
  List<PickerDateRange> selectedRanges; //blackout
  List<DateTime> weekend;

  @override
  void initState() {
    void _satandsun() {
      print('Start');
      int firstDay = 1;
      DateTime date = DateTime.now();
      DateTime dateTime = new DateTime(date.year, date.month, date.day);
      int lastDay = DateUtils.getDaysInMonth(date.year, date.month);
      print('lastday:' + lastDay.toString());
      DateTime startMonth = DateTime.utc(date.year, date.month, firstDay);
      DateTime lastMonth = DateTime.utc(date.year, date.month, lastDay);
      int weekStartDate = DateUtils.firstDayOffset(date.year, date.month, null);
      DateTime weekEndDates = DateTime.utc(
          date.year, date.month, date.day, 23, 59, 59, 999, 999999);

      for (int i = firstDay; i <= lastDay; i++) {
        if (dateTime.day == DateTime.sunday ||
            dateTime.day == DateTime.saturday) {
          weekend.add(dateTime);
          // (dateTime != null) ? weekend.add(dateTime.toUtc()) : null;
        }
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    bool _autovalidate = false;
    LeaveRequestData leaveRequest = ModalRoute.of(context).settings.arguments;

    Widget _Container(Widget widget) {
      return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.blueAccent),
          ),
          width: width * 0.4,
          height: height * 0.07,
          child: widget);
    }

    void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
      if (args.value is PickerDateRange) {
        setState(() {
          int firstDay = 1;
          rangeStartDate = args.value.startDate;
          rangeEndDate = args.value.endDate;
          (rangeEndDate != null)
              ? days = rangeEndDate.difference(rangeStartDate).inDays + 1
              : days = 0;
        });
      }
    }

    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamed(context, '/approveLeaveRequest');
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
              title: Text(
                'Leave Info',
                textAlign: TextAlign.start,
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
                      Navigator.pushNamed(context, '/approveLeaveRequest');
                    });
              })),
          body: Container(
            color: Colors.white,
            width: width,
            height: height,
            child: Column(
              children: <Widget>[
                Container(
                  width: width * 0.85,
                  height: height * 0.4,
                  child: SfDateRangePicker(
                    selectionMode: DateRangePickerSelectionMode.range,
                    selectionTextStyle: const TextStyle(color: Colors.white),
                    selectionColor: Colors.blue,
                    startRangeSelectionColor: Colors.blueAccent,
                    endRangeSelectionColor: Colors.blueAccent,
                    rangeSelectionColor: Colors.lightBlueAccent,
                    rangeTextStyle:
                        const TextStyle(color: Colors.white, fontSize: 12),
                    view: DateRangePickerView.month,
                    monthViewSettings: DateRangePickerMonthViewSettings(
                      weekendDays: List<int>()..add(7)..add(6),
                      showTrailingAndLeadingDates: true,
                      blackoutDates: weekend,
                    ),
                    enablePastDates: false,
                    monthCellStyle: DateRangePickerMonthCellStyle(
                        weekendTextStyle: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.red)),
                    onSelectionChanged: _onSelectionChanged,
                  ),
                ),
                Container(
                  width: width,
                  height: height - (height * 0.55),
                  decoration: BoxDecoration(
                      // color: Colors.blueAccent,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: width * 0.4,
                            // color: Colors.amber,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    'Start Date',
                                    style: TextStyle(
                                        fontSize: height * 0.03,
                                        color: Colors.blueAccent),
                                  ),
                                ),
                                _Container(Center(
                                  child: Text(leaveRequest.startDate),
                                )),
                                Container(
                                  child: Text(
                                    'Requested',
                                    style: TextStyle(
                                        fontSize: height * 0.03,
                                        color: Colors.blueAccent),
                                  ),
                                ),
                                _Container(Center(
                                    child: Text(
                                  'days',
                                  style: TextStyle(fontSize: height * 0.025),
                                )))
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width * 0.05,
                          ),
                          Container(
                            width: width * 0.4,
                            // color: Colors.amber,
                            child: Column(
                              children: <Widget>[
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
                                    child: Text(
                                  leaveRequest.endsDate,
                                  style: TextStyle(fontSize: height * 0.025),
                                ))),
                                Container(
                                  child: Text(
                                    'Leave Type',
                                    style: TextStyle(
                                        fontSize: height * 0.03,
                                        color: Colors.blueAccent),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                        Border.all(color: Colors.blueAccent),
                                  ),
                                  width: width * 0.4,
                                  height: height * 0.07,
                                  child: Center(
                                      child: Text(
                                    leaveRequest.status,
                                    style: TextStyle(fontSize: height * 0.025),
                                  )),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.0125,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              bool _autovalidate = true;
                            });
                          },
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                  ),
                                  alignment: Alignment.center,
                                  width: width * 0.25,
                                  height: height * 0.065,
                                  child: Text(
                                    'APPROVE',
                                    style: TextStyle(
                                        fontSize: height * 0.025,
                                        color: Colors.blueAccent),
                                  ),
                                ),
                                // SizedBox(width: ,),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                  ),
                                  alignment: Alignment.center,
                                  width: width * 0.25,
                                  height: height * 0.065,
                                  child: Text(
                                    'REJECT',
                                    style: TextStyle(
                                        fontSize: height * 0.025,
                                        color: Colors.blueAccent),
                                  ),
                                ),
                              ]),
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
}
