import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intcbbta/mockDATA/dataLeaveRequest.dart';
import 'package:intcbbta/model/leave_request_data.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intcbbta/global/global.dart'as globals;


class Approve extends StatefulWidget {
  @override
  _ApproveState createState() => _ApproveState();
}

class _ApproveState extends State<Approve> {
  List<LeaveRequestData>items = List.of(DataLeaveRequest.leaveReq);
  Widget cardApprove(double width,double height){ return Padding(
    padding: EdgeInsets.all(10),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: width,
        height: height * 0.1,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: AssetImage("asset/images/angry.gif"),
              ),
            ),
            Container(
              // color: Colors.amber,
              width: width * 0.6,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Firstname  Lastname",
                      style: TextStyle(
                        fontSize: height * 0.03,
                      ),
                    ),
                    Text(
                      "**/**/**** - **/**/****",
                      style: TextStyle(
                        fontSize: height * 0.025,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
  }

  Widget slideList(String circleAVT,String title,String subtitle,LeaveRequestData items){
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.white,
          child: Card(
            child: ListTile(
              leading:
              (globals.IMAGE!=null)?
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: AssetImage("asset/images/angry.gif"),
                )
              ):CircleAvatar(child: Text(globals.FIRSTNAME[0]+globals.LASTNAME[0]),),
              // CircleAvatar(
              //   backgroundColor: Colors.indigoAccent,
              //   child: Text(circleAVT),
              //   foregroundColor: Colors.white,
              // ),
              title: Text(title),
              subtitle: Text(subtitle),
            ),
          ),
        ),
      ),
      secondaryActions: <Widget>[

        Card(
          child: IconSlideAction(
            caption: 'Reject',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              setState(() {
                items.status="DECLINE";
              });
            },
          ),
        ),
        Card(
        child:IconSlideAction(
          caption: 'Approve',
          color: Colors.green,
          icon: Icons.approval,
          onTap: () {
            items.status="APPROVE";
          },
        )),
    Card(
    child:IconSlideAction(
          caption: 'info',
          color: Colors.black45,
          icon: Icons.more_horiz,
          onTap: () {Navigator.pushNamed(context, "/detailRequest",arguments: items);},
        ))
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
        appBar: AppBar(
            title: Text(
              'Request Management',
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
        body:ListView.builder(itemBuilder: (context,index){
          var item = items[index];
          return slideList(item.fname[0]+item.lname[0], item.fname+" "+item.lname, item.startDate+" - "+item.endsDate+" "+item.status, item);
        },

            itemCount: items.length)
          )
      ),
    );
  }
}
