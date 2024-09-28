import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:i30_app/user/login_user_page.dart';

import '../proses/get_data.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  var dataUser = fetchData();
  //fungsi ambil data user
  static Future fetchData() async {
    // Kode untuk melakukan fetch data pada Future
    var data;
    // simulasi API request
    getDataUser().then((value) => data = value);
    await Future.delayed(Duration(seconds: 2));
    return data;
  }

  Future popUpLogout(context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(
              'Anda yakin ingin keluar?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'InriaSans',
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF484848),
              ),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16, vertical: 10.0),
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF28A8E0),
                  elevation: 0,
                ),
                onPressed: () {
                  _logout();
                },
                child: Text("Ya"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Tidak"),
              ),
            ],
          );
        });
  }

  // Fungsi Logout akun
  void _logout() async {
    await FirebaseAuth.instance.signOut();

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => LoginPageUser()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 40.0),
            SizedBox(
              width: double.infinity,
              child: Text(
                'Profile',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'InriaSans',
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF484848),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 60.0,
                  height: 60.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF3DF27),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: SizedBox(
                      height: 40.0,
                      width: 40.0,
                      child: Image.asset(
                        'assets/img/profileIcon.png',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                FutureBuilder(
                  future: dataUser,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      var data = snapshot.data;

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['custName'],
                            style: TextStyle(
                              fontFamily: 'InriaSans',
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF484848),
                            ),
                          ),
                          Text(
                            data['custId'],
                            style: TextStyle(
                              fontFamily: 'InriaSans',
                              fontSize: 14.0,
                              color: Color(0xFF878585),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return SizedBox(
                        height: 42,
                        width: 120,
                        child: Container(
                          color: Color(0xFFE3E3E3),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                popUpLogout(context);
              },
              icon: Icon(
                Icons.logout,
                color: Color(0xFF28A8E0),
              ),
              label: Text('Keluar',
                  style: TextStyle(
                    fontFamily: 'InriaSans',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF28A8E0),
                    fontSize: 18,
                  )),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Color(0xFFF9F9F9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChangePasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ubah Password'),
      ),
      body: Center(
        child: Text('Ini adalah halaman untuk mengubah password'),
      ),
    );
  }
}
