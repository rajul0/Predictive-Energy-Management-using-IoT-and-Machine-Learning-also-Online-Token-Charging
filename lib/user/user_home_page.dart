import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:i30_app/component/build_card_data_electricity.dart';
import 'package:i30_app/component/feature_btn.dart';
import 'package:i30_app/user/user_prediction_result_page.dart';
import 'package:i30_app/user/user_profile_page.dart';
import 'package:i30_app/user/user_refill_page.dart';
import 'package:i30_app/user/user_usage_page.dart';
import '../proses/get_data.dart';

class HomePageUser extends StatefulWidget {
  const HomePageUser({super.key});

  @override
  State<HomePageUser> createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  var dataUser = fetchLocal();

  static Future fetchData() async {
    // Kode untuk melakukan fetch data pada Future
    var data;
    // simulasi API request
    getDataUser().then((value) => data = value);
    await Future.delayed(Duration(seconds: 2));
    return data;
  }

  void _usagePage(token) async {
    try {
      var custId;
      var data = fetchData();
      data.then((value) => custId = value['custId']);
      await Future.delayed(Duration(seconds: 2));
    } catch (error) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      body: SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            Container(
              height: 189.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xFF28A8E0),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      20,
                    ),
                    bottomRight: Radius.circular(20),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 49,
                        ),
                        FutureBuilder(
                          future: dataUser,
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              var data = snapshot.data;
                              return Text(
                                'Hi, ${data["custName"]}',
                                style: TextStyle(
                                    color: Color(0xFFF9F9F9),
                                    fontFamily: 'InriaSans',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              );
                            } else {
                              return SizedBox(
                                height: 22,
                                width: 60,
                                child: Container(
                                  color: Color(0xFFE3E3E3),
                                ),
                              );
                            }
                          },
                        ),
                        Row(
                          children: [
                            Text(
                              'Lets start fill your tokens by this app',
                              style: TextStyle(
                                color: Color(0xFFF9F9F9),
                                fontFamily: 'InriaSans',
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 16.0,
                              child:
                                  Image.asset('assets/img/wavehand_icon.png'),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 60,
                      child: Image.asset(
                        'assets/img/profileIcon.png',
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 12.0, bottom: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What’s your can do',
                    style: TextStyle(
                      color: Color(0xFF484848),
                      fontFamily: 'InriaSans',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 19.0,
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 26.0,
                    children: [
                      buildFeatureBtn(
                        context,
                        'Refill Tokens',
                        'assets/img/refill_tokens_icon.png',
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserRefillPage()),
                          );
                        },
                      ),
                      buildFeatureBtn(
                        context,
                        'Usage',
                        'assets/img/usage_icon.png',
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserUsagePage()),
                          );
                        },
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 19.0,
                      ),
                      buildFeatureBtn(
                        context,
                        'Prediction',
                        'assets/img/prediction.png',
                        () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserPredictionResult()),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 60.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF28A8E0).withOpacity(0.35),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          electricityData(context, 'Lead Token [Rp]',
                              'harga_token', '', true),
                          SizedBox(
                            height: 10.0,
                          ),
                          electricityData(
                              context, 'Voltage [V]', 'tegangan', 'V', false),
                          SizedBox(
                            height: 10.0,
                          ),
                          electricityData(
                              context, 'Current [A]', 'arus', 'A', false),
                          SizedBox(
                            height: 10.0,
                          ),
                          electricityData(
                              context, 'Power [W]', 'daya', 'W', false),
                          SizedBox(
                            height: 10.0,
                          ),
                          electricityData(context, 'Frequency [Hz]',
                              'frekuensi', 'Hz', false),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ])),
    );
  }
}

class NavbarBtmUser extends StatefulWidget {
  @override
  _NavbarBtmUserState createState() => _NavbarBtmUserState();
}

class _NavbarBtmUserState extends State<NavbarBtmUser> {
  int _selectedIndex = 0;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final List<String> _imgIcons = [
    'assets/img/homeIcon.png',
    'assets/img/profileIcon.png',
  ];

  final List<Widget> _widgetOptions = [
    HomePageUser(),
    UserProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: _selectedIndex ==
                    _imgIcons.indexOf(
                      'assets/img/homeIcon.png',
                    )
                ? SizedBox(
                    height: 40,
                    child: Image.asset('assets/img/homeIconOnclick.png'),
                  )
                : SizedBox(
                    height: 40,
                    child: Image.asset('assets/img/homeIcon.png'),
                  ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex ==
                    _imgIcons.indexOf('assets/img/profileIcon.png')
                ? SizedBox(
                    height: 40,
                    child: Image.asset('assets/img/profileIconOnclick.png'),
                  )
                : SizedBox(
                    height: 40,
                    child: Image.asset('assets/img/profileIcon.png'),
                  ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
