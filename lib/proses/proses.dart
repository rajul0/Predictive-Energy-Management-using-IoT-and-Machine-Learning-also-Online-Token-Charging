import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

Future<List> checkToken(tokenNumber) async {
  List hasil = [];
  // Mendapatkan referensi ke koleksi "users"
  CollectionReference users = FirebaseFirestore.instance.collection('token');

  // Mendapatkan data dari koleksi "users"
  QuerySnapshot querySnapshot =
      await users.where('token_number', isEqualTo: tokenNumber).get();

  // Looping untuk mendapatkan data setiap dokumen pada querySnapshot
  if (querySnapshot.size == 0) {
    hasil.add('Invalid Token Number');
  } else {
    hasil.add('Berhasil');
  }
  return hasil;
}

Future<List> refillToken(tokenNumber) async {
  List hasil = [];
  // Mendapatkan referensi ke koleksi "users"
  CollectionReference users = FirebaseFirestore.instance.collection('token');

  // Mendapatkan data dari koleksi "users"
  QuerySnapshot querySnapshot =
      await users.where('token_number', isEqualTo: tokenNumber).get();

  // Looping untuk mendapatkan data setiap dokumen pada querySnapshot
  if (querySnapshot.size == 0) {
    hasil.add('Invalid Token Number');
  } else {
    querySnapshot.docs.forEach((doc) async {
      final ref = FirebaseDatabase.instance.ref('/');
      final snapshotRealtime = await ref.child('harga_token').get();

      if (snapshotRealtime.exists) {
        var hargaTokenSekarang = snapshotRealtime.value;
        var hargaToken = doc['harga_token'];
        await Future.delayed(Duration(seconds: 2));
        var hargaTokenBaru = hargaToken + hargaTokenSekarang;
        await ref.update(
          {'harga_token': hargaTokenBaru},
        );
        hasil.add('berhasil');
        users.doc(doc.id).delete();
      } else {
        print('No data available.');
      }
    });
  }
  return hasil;
}
