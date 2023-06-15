import 'package:flutter/material.dart';

Widget buildFeatureBtn(
    BuildContext context, String name, image, VoidCallback onPressed) {
  return GestureDetector(
    onTap: onPressed,
    child: SizedBox(
      width: 147,
      height: 33,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFF28A8E0), width: 0.5),
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.0,
            top: 6.0,
            bottom: 7.0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: SizedBox(
                  height: 20.0,
                  width: 20.0,
                  child: Image.asset(
                    image,
                    width: 20.0,
                  ),
                ),
              ),
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'InriaSans',
                  fontSize: 16.0,
                  color: Color(0xFF484848),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
