import 'package:flutter/material.dart';
import 'package:intcbbta/model/device_all.dart';
class DetailDevice extends StatefulWidget {
  @override
  _DetailDeviceState createState() => _DetailDeviceState();
}

class _DetailDeviceState extends State<DetailDevice> {
  final _formKey = GlobalKey<FormState>();
  var code = TextEditingController();
  var nameDevice = TextEditingController();
  var category = TextEditingController();
  bool _autovalidate = false;
  List<String> itemCategory = [];
  String msCategory="";

  String validateRequired(String val, String fieldname) {
    if (val == null || val == '') return '$fieldname is Required';
    return null;
  }

  Widget _DropFormField(
      String _value,
      String _hint,
      ) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8, right: 15),
      child: DropdownButtonFormField(
          decoration: InputDecoration(
            focusColor: Colors.blueAccent,
            border: OutlineInputBorder(),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          ),
          hint: Text(_hint),
          items: itemCategory.map<DropdownMenuItem<String>>((String _value) {
            return DropdownMenuItem(value: _value, child: Text(_value));
          }).toList(),
          autovalidate: _autovalidate,
          onChanged: (position) => setState(()
          {_value = position;
          msCategory=_value;}),
          validator: (value) => value == null ? '$_hint required' : null),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    DeviceAll deviceAll = ModalRoute.of(context).settings.arguments;
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamed(context, '/deviceList');
      },
          child: SafeArea(child: Scaffold(
        appBar:AppBar(
            title: Text(
              'Device Info',
              textAlign: TextAlign.start,
              style:TextStyle(color: Colors.blueAccent, fontSize: height * 0.05),
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
                    Navigator.pushNamed(context, '/deviceList');
                  });
            })),
        body: Column(
          children: <Widget>[

          ],
        ),
      )),
    );
  }
}
