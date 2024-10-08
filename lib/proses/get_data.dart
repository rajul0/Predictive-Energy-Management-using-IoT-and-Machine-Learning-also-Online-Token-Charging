import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<dynamic> getDataUser() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = _auth.currentUser;
  String? _userId = user?.uid;

  var userData = {};
  // Mendapatkan referensi ke koleksi "users"
  CollectionReference users =
      FirebaseFirestore.instance.collection('user_data');

  // Mendapatkan data dari koleksi "users"
  QuerySnapshot querySnapshot =
      await users.where('id_user', isEqualTo: _userId).get();

  // Looping untuk mendapatkan data setiap dokumen pada querySnapshot
  querySnapshot.docs.forEach((doc) {
    userData['custId'] = doc['customer_id'];
    userData['custName'] = doc['customer_name'];
    userData['idUser'] = doc['id_user'];
  });
  return userData;
}

Future<List> getDataRflHistory() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = _auth.currentUser;
  String? _userId = user?.uid;
  List hasil = [];
  // Mendapatkan referensi ke koleksi "users"
  CollectionReference users =
      FirebaseFirestore.instance.collection('refill_history');

  // Mendapatkan data dari koleksi "users"
  QuerySnapshot querySnapshot =
      await users.where('id_user', isEqualTo: _userId).get();

  // Looping untuk mendapatkan data setiap dokumen pada querySnapshot
  querySnapshot.docs.forEach((doc) {
    var data = {};
    data['custId'] = doc['customer_id'];
    data['hargaToken'] = doc['price'];
    data['tanggalRfl'] = doc['charging_date'];
    data['tokenNumber'] = doc['token_number'];
    data['kwh'] = doc['kwh'];
    hasil.add(data);
  });
  return hasil;
}

Future<List> getPrediction(custId) async {
  List hasil = [];
  // Mendapatkan referensi ke koleksi "users"
  CollectionReference users =
      FirebaseFirestore.instance.collection('prediction');

  // Mendapatkan data dari koleksi "users"
  QuerySnapshot querySnapshot =
      await users.where('customer_id', isEqualTo: custId).get();

  // Looping untuk mendapatkan data setiap dokumen pada querySnapshot
  querySnapshot.docs.forEach((doc) {
    var data = {};
    data['custId'] = doc['customer_id'];
    data['kwh'] = doc['kwh'];
    data['priceForKwh'] = doc['price_for_kwh'];
    hasil.add(data);
  });
  return hasil;
}

Future<List> getUsageAllMonth() async {
  final HARGA_PER_KWH = 415;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = _auth.currentUser;
  String? _userId = user?.uid;
  List hasil = [];
  // Mendapatkan referensi ke koleksi "users"
  CollectionReference users = FirebaseFirestore.instance.collection('usage');

  // Mendapatkan data dari koleksi "users"
  QuerySnapshot querySnapshot =
      await users.where('customer_id', isEqualTo: _userId).get();

  // Looping untuk mendapatkan data setiap dokumen pada querySnapshot
  querySnapshot.docs.forEach((doc) {
    var data = {};
    data['month'] = doc['month'];
    data['custId'] = doc['customer_id'];

    String kwhString =
        doc['kwh'].toStringAsFixed(2); // Ubah kwh jadi 2 angka dibelakang koma
    double kwhAngka =
        double.parse(kwhString); // Ubah kwh jadi 2 angka dibelakang koma

    data['kwh'] = kwhAngka;
    data['totalPrice'] = kwhAngka * HARGA_PER_KWH;
    hasil.add(data);
  });
  return hasil;
}

Future<List> fetchDataPredict() async {
  final HARGA_PER_KWH = 415;
  List dataPredict = [[], [], [], []];
  var sisaToken;
  getSisaToken().then((value) => sisaToken = value);

  List<int> waktu = [1, 3, 7, 14, 21, 30];
  // List<int> waktu = [7];

  for (int w in waktu) {
    var url = Uri.parse(
        'https://fcd19486-5bda-4d78-8e06-4f5770d6a9cb-00-34wcxdp4o6lsy.kirk.replit.dev/predict?day=$w'); // Url API

    try {
      var response =
          await http.get(url); // mendapatkan data predict penggunaan dari api

      if (response.statusCode == 200) {
        // Permintaan berhasil, proses olah datanya dibawah ini
        dynamic jsonData = json.decode(response.body);
        var temp = (hitungTotal(jsonData[
            'result'])); // mengtotalkan KWH penggunaan dalam beberapa hari

        String totalKwhString = temp.toStringAsFixed(2);
        double totalPenggunaanKwh = double.parse(totalKwhString);

        double priceTemp = totalPenggunaanKwh * HARGA_PER_KWH;
        String priceString = priceTemp.toStringAsFixed(
            2); // ngubah hanya 2 angka dibelakang koma, tipenya string
        double price = double.parse(priceString);

        dataPredict[0].add('$w Hari');
        dataPredict[1].add(totalPenggunaanKwh);
        dataPredict[2].add(price);
      } else {
        // Permintaan gagal dengan kode status selain 200
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      // Jika Terjadi kesalahan saat melakukan permintaan
      print('Error sending request: $error');
    }
  }

  dataPredict[3].add(sisaToken);
  return dataPredict;
}

double hitungTotal(List data) {
  // fungsi ini untuk menghitung total penggunaan listrik dalam beberapa hari
  // mengembalikan nilai bertipe data double yang merupakan total penggunaan
  double totalPenggunaan = 0;
  for (int i = 0; i < data.length; i++) {
    var satuHari = data[i][0];
    totalPenggunaan += satuHari;
  }
  return totalPenggunaan;
}

Future getSisaToken() async {
  // Fungsi untuk mengambil sisa harga token dari FRTD
  // buat instance
  final ref = FirebaseDatabase.instance.ref('/');
  final snapshotRealtime = await ref.child('harga_token').get();

  if (snapshotRealtime.exists) {
    var hargaTokenSekarang = snapshotRealtime.value;
    await Future.delayed(Duration(seconds: 2));
    return hargaTokenSekarang;
  } else {
    print('No data available.');
  }
}
