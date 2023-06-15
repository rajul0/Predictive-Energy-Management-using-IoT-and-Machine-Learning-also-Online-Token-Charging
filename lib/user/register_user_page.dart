import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:i30_app/component/regis_succes.dart';
import 'package:i30_app/proses/proses_akun.dart';
import 'package:i30_app/user/login_user_page.dart';

class RegisterUserPage extends StatefulWidget {
  @override
  _RegisterUserPageState createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  // confirm password
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _confirmPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _confirmPasswordVisible = !_confirmPasswordVisible;
    });
  }

  // nyimpan error message
  String _errorMessage = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  Future<User?> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      if (_formKey.currentState!.validate()) {
        final UserCredential authResult =
            await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        final User? user = authResult.user;
        await user?.updateDisplayName('user');
        // Pop Up berhasil daftar Akun
        popUpRegisSucces(context);

        // Tambah data user ke database
        addUserData(_auth, _storage, _db, user?.uid, _fullName, email, password,
            'user');
      } else {
        setState(
          () {
            _autoValidateMode = AutovalidateMode.always;
          },
        );
      }
    } catch (e) {
      if ('[firebase_auth/email-already-in-use] The email address is already in use by another account.' ==
          e.toString()) {
        setState(() {
          _errorMessage =
              'The email address is already in use by another account!';
        });
      } else {}
    }
  }

  // fullname, email,dan password yang diinput

  String _fullName = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
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
                  Text(
                    'Register Account',
                    style: TextStyle(
                      fontFamily: 'InriaSans',
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF484848),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 11.0,
              ),
              Row(
                children: [
                  Text(
                    'Create your account to start use the app',
                    style: TextStyle(
                      fontFamily: 'InriaSans',
                      fontSize: 14.0,
                      color: Color(0xFF878585),
                    ),
                  ),
                  SizedBox(
                    width: 2.0,
                  ),
                  SizedBox(
                      height: 16.0,
                      width: 16.0,
                      child: Image.asset('assets/img/peace.png'))
                ],
              ),
              const SizedBox(
                height: 67,
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
                      onChanged: (value) {
                        setState(() {
                          _fullName = value;
                        });
                      },
                      decoration: InputDecoration(
                          labelText: 'Full Name',
                          labelStyle: TextStyle(
                            color: Color(0xFF28A8E0),
                          ),
                          hintText: 'Enter your Full Name',
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                height: 24,
                                width: 24,
                                child: Image.asset('assets/img/user0.png'),
                              ),
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
                      height: 20.0,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                          _errorMessage = '';
                        });
                      },
                      decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Color(0xFF28A8E0),
                          ),
                          hintText: 'Enter your email',
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: Image.asset('assets/img/phone.png')),
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
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_passwordVisible,
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Color(0xFF28A8E0),
                        ),
                        hintText: 'Enter your password',
                        prefixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                                height: 24,
                                width: 24,
                                child: Image.asset('assets/img/key.png')),
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
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          borderSide: BorderSide(color: Color(0xFF28A8E0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(color: Color(0xFF28A8E0))),
                        focusedBorder: (OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(color: Color(0xFF28A8E0)))),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Color(0xFF28A8E0),
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                      style: TextStyle(
                          fontFamily: 'InriaSans',
                          fontSize: 16,
                          color: Color(0xFF484848)),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: !_confirmPasswordVisible,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password again';
                        }
                        if (value != _password) {
                          return 'Password does not match';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _confirmPassword = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(
                          color: Color(0xFF28A8E0),
                        ),
                        hintText: 'Enter your password again',
                        prefixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                                height: 24,
                                width: 24,
                                child: Image.asset('assets/img/key.png')),
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
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          borderSide: BorderSide(color: Color(0xFF28A8E0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(color: Color(0xFF28A8E0))),
                        focusedBorder: (OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide(color: Color(0xFF28A8E0)))),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Color(0xFF28A8E0),
                          ),
                          onPressed: _toggleConfirmPasswordVisibility,
                        ),
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
                          signUpWithEmailAndPassword(_email, _password);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 5.0,
                          backgroundColor: Color(0xFF28A8E0),
                        ),
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontFamily: 'InriaSans',
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?',
                            style: TextStyle(
                              color: Color(0xFF484848),
                              fontFamily: 'InriaSans',
                              fontSize: 14.0,
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPageUser(),
                              ),
                            );
                          },
                          child: Text('Login',
                              style: TextStyle(
                                  fontFamily: 'InriaSans',
                                  fontSize: 14.0,
                                  decoration: TextDecoration.underline,
                                  color: Color(0xFF0095DA))),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
