import 'package:flutter/material.dart';
import 'package:i30_app/user/user_home_page.dart';

Future popUpBerhasilRfl(context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(
            'Isi Token Berhasil',
            textAlign: TextAlign.center,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10.0),
          children: <Widget>[
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Color(0xFF0095DA)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NavbarBtmUser()));
              },
              child: Text(
                "OK",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      });
}
