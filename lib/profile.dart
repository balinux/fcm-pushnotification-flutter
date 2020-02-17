import 'package:androidx_flutter_dev/api.dart';
import 'package:androidx_flutter_dev/set_token_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  bool isSwitch = false;
  String tokenFcm;
  SetToken _setToken;

  @override
  void initState() {
    tokenSetter();
    _firebaseMessaging.getToken().then((value) {
      print("$value");
      setState(() {
        tokenFcm = value;
      });
    });
    super.initState();
  }

  changeSwitch(bool value) {
    setState(() {
      isSwitch = value;
    });
    tokenSetter();
  }

  Future<void> tokenSetter() async {
    var token = await Api().setTokenToServer(32018000182, tokenFcm);
    print(token.changedRows);
    // var user = await Api().getUser();
    // print(user.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        children: <Widget>[
          Center(
            child: Text('Profile Page'),
          ),
          Center(
            child: tokenFcm != null ? Text(tokenFcm) : Container(),
          ),
          Center(
            child: _setToken != null
                ? Text(_setToken.affectedRows.toString())
                : Container(),
          ),
          Switch(
            value: isSwitch,
            onChanged: (value) {
              changeSwitch(value);
            },
            activeColor: Colors.blue,
            activeTrackColor: Colors.lightBlueAccent,
          )
        ],
      ),
    );
  }
}
