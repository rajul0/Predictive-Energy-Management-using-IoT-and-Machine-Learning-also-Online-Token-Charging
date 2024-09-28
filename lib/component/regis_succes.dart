import 'package:flutter/material.dart';
import 'package:i30_app/user/login_user_page.dart';

Future popUpRegisSucces(context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(
            'Succesfully!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'InriaSans',
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF484848),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10.0),
          children: <Widget>[
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xFF0095DA)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPageUser()));
              },
              child: Text("OK"),
            ),
          ],
        );
      });
}
