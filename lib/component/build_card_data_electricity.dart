import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget electricityData(BuildContext context, String title, String column,
    String satuan, bool harga) {
  var currencyFormat = NumberFormat.currency(
    symbol: "Rp",
    decimalDigits: 0,
    locale: "id_ID",
  );

  final databaseReference = FirebaseDatabase.instance.ref();
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
    child: SizedBox(
      height: 40.0,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, top: 9, right: 10, bottom: 9),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$title',
              style: TextStyle(
                  fontFamily: 'Inria Sans',
                  color: Color(0xFF484848),
                  fontSize: 14.0),
            ),
            StreamBuilder(
              stream: databaseReference.child(column).onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
                  var data = snapshot.data!.snapshot.value;

                  var title = data;
                  if (harga) {
                    title = currencyFormat.format(data);
                  }
                  return Text(
                    '$title $satuan',
                    style: TextStyle(
                        fontFamily: 'Inria Sans',
                        color: Color(0xFF484848),
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold),
                  );
                } else {
                  return Text('Loading...');
                }
              },
            ),
          ],
        ),
      ),
    ),
  );
}
