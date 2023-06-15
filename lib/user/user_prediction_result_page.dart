import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:i30_app/component/usage_month_card.dart';
import 'package:i30_app/proses/proses.dart';
import 'package:intl/intl.dart';

import '../component/predict_card.dart';
import '../proses/get_data.dart';

class UserPredictionResult extends StatefulWidget {
  @override
  _UserPredictionResultState createState() => _UserPredictionResultState();
  const UserPredictionResult({
    super.key,
  });
}

class _UserPredictionResultState extends State<UserPredictionResult> {
  // nyimpan error message
  String _errorMessage = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  // Fungsi ngambil data prediction customer
  static Future fetchData() async {
    var data = fetchDataPredict();
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
                        'Prediction',
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
                          Text('Please wait, making predictions'),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      // Ketika terjadi error dalam pengambilan data
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data.isEmpty) {
                      return Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        "There are some Problems, check again in a few minutes",
                        style: TextStyle(
                            fontFamily: 'Inria Sans',
                            fontSize: 14.0,
                            color: Color(0xFF878585)),
                      );
                    } else {
                      var datas = snapshot.data;
                      return Column(
                        children: List.generate(
                            datas[0].length,
                            (index) => buildPredictCard(
                                context,
                                datas[0][index],
                                datas[1][index],
                                datas[2][index],
                                datas[3][0],
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
