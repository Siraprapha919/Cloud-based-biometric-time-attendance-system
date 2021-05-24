import 'package:flutter/material.dart';
class ListFaceManagement extends StatefulWidget {
  @override
  _ListFaceManagementState createState() => _ListFaceManagementState();
}

class _ListFaceManagementState extends State<ListFaceManagement> {

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
                    'Face menu',
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
                          Navigator.pushNamed(context, '/adminDashboard');
                        });
                  })),
              body: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/viewallstaff');
                    },
                    child: myButton(
                        context, width, height, 'user', Icons.accessibility),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/face_access');
                    },
                    child: myButton(
                        context, width, height, 'face access', Icons.accessibility),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/request_update');
                    },
                    child: myButton(
                        context, width, height, 'face request update', Icons.fact_check_outlined),
                  ),
                ],
              ))),
    );
  }
  myButton(BuildContext context, double width, double height, String text,IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 5,top: 5),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Container(
          height: height * 0.07,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Icon(icon,size: 30,),
              SizedBox(
                width: 15,
              ),
              Text(
                text,
                style: TextStyle(fontSize: height * 0.03),
              ),
            ],
          ),
        ),
      ),
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



