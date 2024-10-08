import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget buildPredictCard(BuildContext context, String waktu, kwh, price,
    tokenSekarang, VoidCallback onPressed) {
  var currencyFormat = NumberFormat.currency(
    symbol: "Rp",
    decimalDigits: 0,
    locale: "id_ID",
  );
  var priceFormat;
  if (price != '') {
    priceFormat = currencyFormat.format(price);
  }
  return GestureDetector(
    onTap: onPressed,
    child: SizedBox(
      width: double.infinity,
      height: 70,
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      waktu,
                      style: TextStyle(
                        fontFamily: 'InriaSans',
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF484848),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    tokenSekarang >= price
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${kwh} Kwh',
                                style: TextStyle(
                                  fontFamily: 'InriaSans',
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              Text(
                                priceFormat,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontFamily: 'InriaSans',
                                  fontSize: 14.0,
                                  color: Color(0xFF28A8E0),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${kwh} Kwh',
                                style: TextStyle(
                                  fontFamily: 'InriaSans',
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              Text(
                                priceFormat,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontFamily: 'InriaSans',
                                  fontSize: 14.0,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          )
                  ],
                ),
              ],
            ),
            Divider(
              color: Color(0xFFEBEBEB),
              thickness: 1.0,
            ),
          ],
        ),
      ),
    ),
  );
}
