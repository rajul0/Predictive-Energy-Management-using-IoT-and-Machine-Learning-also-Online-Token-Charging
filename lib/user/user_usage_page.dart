import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:i30_app/component/usage_month_card.dart';
import 'package:intl/intl.dart';

import '../proses/get_data.dart';

class UserUsagePage extends StatefulWidget {
  @override
  _UserUsagePageState createState() => _UserUsagePageState();
  const UserUsagePage({
    super.key,
  });
}

class _UserUsagePageState extends State<UserUsagePage> {
  // nyimpan error message
  String _errorMessage = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  // Fungsi ngambil data prediction customer
  static Future<List> fetchData() async {
    var data = getUsageAllMonth();
    await Future.delayed(Duration(seconds: 2));

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 40.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          height: 34.0,
                          width: 34.0,
                          child: Image.asset('assets/img/back.png'),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        'Usage',
                        style: TextStyle(
                          fontFamily: 'InriaSans',
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF484848),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 134,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 30.0,
                  left: 20.0,
                  right: 20.0,
                ),
                child: FutureBuilder(
                  future: fetchData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 20,
                          ),
                          Text('Please wait, fetching data on progress'),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      // Ketika terjadi error dalam pengambilan data
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                      return Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        "Your Electric Meter has no usage yet",
                        style: TextStyle(
                            fontFamily: 'Inria Sans',
                            fontSize: 14.0,
                            color: Color(0xFF878585)),
                      );
                    } else {
                      var datas = snapshot.data;
                      return Column(
                        children: List.generate(
                            datas.length,
                            (index) => buildUsageCard(
                                context,
                                datas[index]['month'],
                                datas[index]['kwh'],
                                datas[index]['totalPrice'],
                                () {})),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
