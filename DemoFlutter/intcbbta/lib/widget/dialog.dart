import 'package:flutter/material.dart';
class DialogPop extends StatefulWidget {
  String title;
  String desc;
  @override
  _DialogPopState createState() => _DialogPopState(title,desc);
}

class _DialogPopState extends State<DialogPop> {
  String title;
  String desc;
  _DialogPopState(this.title, this.desc);

  @override
  Widget build(BuildContext context) {
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

        Image.asset("/asset/images/mis.gif"),
        Image(image: AssetImage("/asset/images/mis.gif")),
        Positioned(
          left: 16,
          right: 16,
          child: CircleAvatar(
            radius: 65,
            backgroundImage:AssetImage("asset/images/mis.gif"),
          ),
        ),
      ],
    );
  }
}

