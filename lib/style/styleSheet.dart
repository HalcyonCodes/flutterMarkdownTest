import 'package:flutter/material.dart';

class StyleSheet {
  TextStyle? fatherTextStyle;
  
  void setStyleSheet(){
    a = fatherTextStyle!.copyWith(
      color: Color.fromRGBO(65, 131, 196, 1.0),
    );

    aHover = fatherTextStyle!.copyWith(
    color: Color.fromRGBO(51, 153, 255, 1.0),
  );

   em = fatherTextStyle!.copyWith(
    fontStyle: FontStyle.italic,
  );

   strong = fatherTextStyle!.copyWith(
    fontWeight: FontWeight.w700,
  );

   del = fatherTextStyle!.copyWith(
    decoration: TextDecoration.lineThrough,
  );
  }

  TextStyle normalStyle = TextStyle(
    fontSize: 14,
    color: Colors.black,
    decoration: TextDecoration.none,
    fontWeight: FontWeight.normal,
    height: 1.6,
    package: 'md_fditor',
    fontFamily: 'YAHEI',
  );

  TextStyle h1 = TextStyle(
    fontSize: 31.5,
    fontWeight: FontWeight.w700,
    height: 1.2,
    color: Colors.black,
    decoration: TextDecoration.none,
    package: 'md_fditor',
    fontFamily: 'YAHEI',
  );

  TextStyle h2 = TextStyle(
    fontSize: 24.5,
    fontWeight: FontWeight.w700,
    height: 1.225,
    color: Colors.black,
    decoration: TextDecoration.none,
    package: 'md_fditor',
    fontFamily: 'YAHEI',
  );

  TextStyle h3 = TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w700,
    height: 1.43,
    color: Colors.black,
    decoration: TextDecoration.none,
    package: 'md_fditor',
    fontFamily: 'YAHEI',
  );

  TextStyle h4 = TextStyle(
    fontSize: 17.5,
    fontWeight: FontWeight.w700,
    height: 1.4,   
    color: Colors.black,
    decoration: TextDecoration.none,
    package: 'md_fditor',
    fontFamily: 'YAHEI',
  );

  TextStyle h5 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.4,
    color: Colors.black,
    decoration: TextDecoration.none,
    package: 'md_fditor',
    fontFamily: 'YAHEI',
  );

  TextStyle h6 = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      height: 1.4,
      color: Color.fromRGBO(119, 119, 119, 1.0),
      decoration: TextDecoration.none,
      package: 'md_fditor',
      fontFamily: 'YAHEI',
  );

  TextStyle? a;

  TextStyle? aHover ;

  TextStyle? em ;

  TextStyle? strong ;

  TextStyle? del ;
}
