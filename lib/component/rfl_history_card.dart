import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget rflHistoryCard(BuildContext context, String custId, int price,
    String chargingDate, VoidCallback onPressed) {
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
      height: 106,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF000000).withOpacity(0.25),
                spreadRadius: 0,
                blurRadius: 4.0,
                offset: Offset(0, 0),
              )
            ]),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            right: 20.0,
            bottom: 10.0,
            left: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Customer ID',
                    style: TextStyle(
                      fontFamily: 'InriaSans',
                      fontSize: 14.0,
                      color: Color(0xFFB8B8B8),
                    ),
                  ),
                  Text(
                    custId,
                    style: TextStyle(
                      fontFamily: 'InriaSans',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF484848),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price',
                    style: TextStyle(
                      fontFamily: 'InriaSans',
                      fontSize: 14.0,
                      color: Color(0xFFB8B8B8),
                    ),
                  ),
                  Text(
                    priceFormat,
                    style: TextStyle(
                      fontFamily: 'InriaSans',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF484848),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Charging Date',
                    style: TextStyle(
                      fontFamily: 'InriaSans',
                      fontSize: 14.0,
                      color: Color(0xFFB8B8B8),
                    ),
                  ),
                  Text(
                    chargingDate,
                    style: TextStyle(
                      fontFamily: 'InriaSans',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF484848),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
