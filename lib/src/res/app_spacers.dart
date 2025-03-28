import 'package:flutter/material.dart';

class Spacers {
  static const h2 = SizedBox(height: 2);
  static const h3 = SizedBox(height: 3);
  static const h4 = SizedBox(height: 4);
  static const h5 = SizedBox(height: 5);
  static const h10 = SizedBox(height: 10);
  static const h15 = SizedBox(height: 15);
  static const h20 = SizedBox(height: 20);
  static const h25 = SizedBox(height: 25);
  static const h30 = SizedBox(height: 30);
  static const h35 = SizedBox(height: 35);
  static const h40 = SizedBox(height: 40);

  static const w2 = SizedBox(width: 2);
  static const w3 = SizedBox(width: 3);
  static const w4 = SizedBox(width: 4);
  static const w5 = SizedBox(width: 5);
  static const w10 = SizedBox(width: 10);
  static const w15 = SizedBox(width: 15);
  static const w20 = SizedBox(width: 20);
  static const w25 = SizedBox(width: 25);
  static const w30 = SizedBox(width: 30);
  static const w40 = SizedBox(width: 40);

  static Widget customW(double space) => SizedBox(width: space);
  static Widget customH(double space) => SizedBox(height: space);
}
