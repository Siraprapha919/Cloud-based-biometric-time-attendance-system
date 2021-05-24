import 'dart:io';

import 'package:flutter/material.dart';

import 'package:intcbbta/superUser/add_blacklist.dart';
import 'package:intcbbta/superUser/adminDashboard.dart';
import 'package:intcbbta/superUser/config_menu.dart';
import 'package:intcbbta/superUser/device_register.dart';
import 'package:intcbbta/superUser/approve.dart';
import 'package:intcbbta/superUser/detail_request.dart';
import 'package:intcbbta/superUser/device_info.dart';
import 'package:intcbbta/superUser/device_view.dart';
import 'package:intcbbta/superUser/device_update.dart';
import 'package:intcbbta/superUser/edit_user.dart';
import 'package:intcbbta/superUser/face_management_list.dart';
import 'package:intcbbta/superUser/face_management_request_update.dart';
import 'package:intcbbta/superUser/face_view_all.dart';
import 'package:intcbbta/superUser/register_by_admin.dart';
import 'package:intcbbta/superUser/register_info.dart';
import 'package:intcbbta/superUser/view_log_info.dart';
import 'package:intcbbta/superUser/view_visitor.dart';
import 'package:intcbbta/superUser/face_management_access.dart';
import 'package:intcbbta/user/edit_profile.dart';
import 'package:intcbbta/user/face_register.dart';
import 'package:intcbbta/user/user_dashboards.dart';
import 'package:intcbbta/user/face_update.dart';
import 'package:intcbbta/user/requested_leaved.dart';
import 'package:intcbbta/user/login.dart';
import 'package:intcbbta/user/user_register.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "ThaiSansNeue",
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/faceRegis': (BuildContext context) => FaceRegister(),
        '/login': (BuildContext context) => Signin(),
        '/register': (BuildContext context) => Signup(),
        '/createDevice': (BuildContext context) => AddDevice(),
        '/userDashboard': (BuildContext context) => Dashboard(),
        '/requestLeave': (BuildContext context) => RequestedLeave(),
        '/approveLeaveRequest': (BuildContext context) => Approve(),
        '/adminDashboard': (BuildContext context) => AdminDashboard(),
        '/addFace': (BuildContext context) => AddBlackList(),
        '/deviceList': (BuildContext context) => Device(),
        '/ViewVisiter': (BuildContext context) => ViewVisiter(),
        '/face_access': (BuildContext context) => ViewAccesslist(),
        '/detailRequest': (BuildContext context) => DetailRequest(),
        '/detailDevice': (BuildContext context) => DetailDevice(),
        '/deviceUpdate': (BuildContext context) => DeviceUpdate(),
        '/faceUpdate': (BuildContext context) => FaceUpdate(),
        '/updateInfo': (BuildContext context) => EditProfile(),
        '/logInfo': (BuildContext context) => LogInfo(),
        '/face_manage': (BuildContext context) => ListFaceManagement(),
        '/request_update': (BuildContext context) => ApproveFaceUpdate(),
        '/configmenu': (BuildContext context) => ConfigMenu(),
        '/viewallstaff': (BuildContext context) => ViewAllStaff(),
        '/RegisterByAdmin': (BuildContext context) => RegisterByAdmin(),
        '/editUser': (BuildContext context) => EditUser(),
        '/facerequest': (BuildContext context) => FaceRequestInfo(),
        //FaceRequestInfo
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
