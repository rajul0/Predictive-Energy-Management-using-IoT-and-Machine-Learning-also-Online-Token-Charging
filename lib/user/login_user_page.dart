import 'package:flutter/material.dart';
import 'package:i30_app/proses/get_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:i30_app/user/user_home_page.dart';

class LoginPageUser extends StatefulWidget {
  @override
  _LoginPageUserState createState() => _LoginPageUserState();
}

class _LoginPageUserState extends State<LoginPageUser> {
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;
  bool _isPasswordValid = true;

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  // nyimpan error message
  String _errorMessage = '';

  void login(custId, custName) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    getDataUser();
    try {
      custName = custName + '@e.com';
      await firebaseAuth.signInWithEmailAndPassword(
          email: custName, password: custId);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      setState(() {
        _errorMessage = '';
      });

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NavbarBtmUser()),
      );
    } on FirebaseAuthException catch (error) {
      setState(() {
        _errorMessage = 'Invalid Customer ID , Name, or be careful spaces';
      });
    }
  }

  // Nyimpan email dan password dari field email dan password
  String _custId = '';
  String _custName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Image(
              image: AssetImage('assets/img/logoApp.png'),
              width: 200,
              height: 200,
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'LOG IN',
              style: TextStyle(
                  fontFamily: 'InriaSans',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF484848),
                  fontSize: 24),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              child: Text(
                _errorMessage,
                style: TextStyle(
                  fontFamily: 'InriaSans',
                  fontSize: 14.0,
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _custId = value;
                  _errorMessage = '';
                });
              },
              decoration: InputDecoration(
                  labelText: 'Customer ID',
                  labelStyle: TextStyle(
                    color: Color(0xFF28A8E0),
                  ),
                  hintText: 'Enter your Customer ID',
                  prefixIcon: Row(mainAxisSize: MainAxisSize.min, children: [
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                        height: 24,
                        width: 24,
                        child: Image.asset('assets/img/cust_id_icon.png')),
                    SizedBox(
                      width: 10,
                    )
                  ]),
                  prefixIconConstraints: BoxConstraints(
                    minWidth: 0,
                    minHeight: 0,
                  ),
                  contentPadding: EdgeInsets.only(top: 8, bottom: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide(color: Color(0xFF28A8E0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(color: Color(0xFF28A8E0))),
                  focusedBorder: (OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(color: Color(0xFF28A8E0))))),
              style: TextStyle(
                  fontFamily: 'InriaSans',
                  fontSize: 16,
                  color: Color(0xFF484848)),
            ),
            SizedBox(height: 20),
            TextField(
              obscureText: _passwordVisible,
              onChanged: (value) {
                setState(() {
                  _custName = value;
                  _errorMessage = '';
                });
              },
              decoration: InputDecoration(
                labelText: 'Customer Name',
                labelStyle: TextStyle(
                  color: Color(0xFF28A8E0),
                ),
                hintText: 'Enter your Customer Name',
                prefixIcon: Row(mainAxisSize: MainAxisSize.min, children: [
                  SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                      height: 24,
                      width: 24,
                      child: Image.asset('assets/img/cust_id_icon.png')),
                  SizedBox(
                    width: 10,
                  )
                ]),
                prefixIconConstraints: BoxConstraints(
                  minWidth: 0,
                  minHeight: 0,
                ),
                contentPadding: EdgeInsets.only(top: 8, bottom: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  borderSide: BorderSide(color: Color(0xFF28A8E0)),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide(color: Color(0xFF28A8E0))),
                focusedBorder: (OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    borderSide: BorderSide(color: Color(0xFF28A8E0)))),
              ),
              style: TextStyle(
                  fontFamily: 'InriaSans',
                  fontSize: 16,
                  color: Color(0xFF484848)),
            ),
            SizedBox(height: 42),
            SizedBox(
              width: double.infinity,
              height: 38.0,
              child: ElevatedButton(
                onPressed: () {
                  login(_custId, _custName);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 5.0,
                  backgroundColor: Color(0xFF28A8E0),
                ),
                child: Text(
                  'Log In',
                  style: TextStyle(
                    fontFamily: 'InriaSans',
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
