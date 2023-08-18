import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:i30_app/component/pop_up_berhasil_rfl.dart';

import '../proses/get_data.dart';
import '../proses/proses.dart';

class UserRefillPage extends StatefulWidget {
  @override
  _UserRefillPageState createState() => _UserRefillPageState();
}

class _UserRefillPageState extends State<UserRefillPage> {
  // nyimpan error message
  String _errorMessage = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  // nomor token
  String _tokenNumber = '';

  //fungsi accept token
  void _refill() async {
    var cekToken;
    try {
      checkToken(_tokenNumber).then((value) => cekToken = value[0]);
      await Future.delayed(Duration(seconds: 2));
      if (_formKey.currentState!.validate() && cekToken == 'Berhasil') {
        setState(() {
          _errorMessage = '';
        });
        refillToken(_tokenNumber);
        popUpBerhasilRfl(context);
      } else if (_formKey.currentState!.validate() &&
          cekToken == 'Nomor Token tidak Valid') {
        setState(() {
          _errorMessage = cekToken;
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = '${error}';
      });
    }
  }

  static Future fetchData() async {
    // Kode untuk melakukan fetch data pada Future
    var data;
    // simulasi API request
    getDataUser().then((value) => data = value);
    await Future.delayed(Duration(seconds: 2));
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Isi Token',
                      style: TextStyle(
                        fontFamily: 'InriaSans',
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF484848),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
              Form(
                key: _formKey,
                autovalidateMode: _autoValidateMode,
                child: Column(
                  children: [
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
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Nomor Token tidak boleh kosong';
                        } else if (value.contains(' ')) {
                          return 'Terdapat spasi pada inputan anda';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _tokenNumber = value;
                          _errorMessage = '';
                        });
                      },
                      decoration: InputDecoration(
                          labelText: 'Nomor Token',
                          labelStyle: TextStyle(
                            color: Color(0xFF28A8E0),
                          ),
                          hintText: 'Masukkan Nomor Token',
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                  height: 24,
                                  width: 24,
                                  child:
                                      Image.asset('assets/img/token_icon.png')),
                              SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                          prefixIconConstraints: BoxConstraints(
                            minWidth: 0,
                            minHeight: 0,
                          ),
                          contentPadding: EdgeInsets.only(top: 8, bottom: 8),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(color: Color(0xFF28A8E0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              borderSide: BorderSide(color: Color(0xFF28A8E0))),
                          focusedBorder: (OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              borderSide:
                                  BorderSide(color: Color(0xFF28A8E0))))),
                      style: TextStyle(
                          fontFamily: 'InriaSans',
                          fontSize: 16,
                          color: Color(0xFF484848)),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 29.0,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: SizedBox(
                          width: 79.0,
                          height: 29.0,
                          child: ElevatedButton(
                            onPressed: () {
                              _refill();
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 0,
                              backgroundColor: Color(0xFF28A8E0),
                            ),
                            child: Text(
                              'Isi',
                              style: TextStyle(
                                fontFamily: 'InriaSans',
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
