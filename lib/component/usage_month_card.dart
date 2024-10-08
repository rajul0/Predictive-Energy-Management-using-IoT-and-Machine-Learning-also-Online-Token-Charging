import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget buildUsageCard(
    BuildContext context, String month, kwh, price, VoidCallback onPressed) {
  var _singkatMonth = {
    'Januari': 'Jan',
    'Februari': 'Feb',
    'Maret': 'Mar',
    'April': 'Apr',
    'Mei': 'Mei',
    'Juni': 'Jun',
    'Juli': 'Jul',
    'Agustus': 'Ags',
    'September': 'Sept',
    'Oktober': 'Okt',
    'November': 'Nov',
    'Desember': 'Des'
  };
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
      height: 72,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_singkatMonth[month]}',
                  style: TextStyle(
                    fontFamily: 'InriaSans',
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF484848),
                  ),
                ),
                Text(
                  '${kwh} Kwh',
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
              height: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${month}',
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
                    fontSize: 14.0,
                    color: Color(0xFF28A8E0),
                  ),
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
