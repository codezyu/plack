import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final drawerAnimDur = 350;
ValueNotifier<int> indexOfMenu =
    ValueNotifier<int>(0); //Timer,Stats,Donate,About,Rate
const kTextStyle = TextStyle(
  letterSpacing: 2.0,
  fontSize: 20,
  fontWeight: FontWeight.w700,
);
const TitleTextStyle = TextStyle(
  letterSpacing: 2.0,
  fontSize: 20,

);
const kInputDecor = InputDecoration(
  border: InputBorder.none,
);

List backgroundC = [
  Color(0xFFF1F2F6),
  Color.fromRGBO(20, 20, 20, 1),
];

List shadowC = [
  Color(0xFFDADFF9),
  Colors.black,
];

List lightShadowC = [
  Colors.white,
  Color.fromRGBO(27, 27, 27, 1),
];

const List textC = [
  Color(0xFF707070),
  Color(0xFFF1F2F6),
];
const Color backgroundNewsColor = Color(0xFFF2F2F2);

const turqoiseGradient = [
  Color.fromRGBO(91, 253, 199, 1),
  Color.fromRGBO(129, 182, 205, 1),
];
const greenGradient = [
  Color.fromRGBO(223, 250, 92, 1),
  Color.fromRGBO(129, 250, 112, 1)
];
const orangeGradient = [
  Color.fromRGBO(253, 255, 93, 1),
  Color.fromRGBO(251, 173, 86, 1),
];
const redGradient = [
  Color.fromRGBO(254, 154, 92, 1),
  Color.fromRGBO(255, 93, 91, 1),
];
List<List<Color>> gradientList = [
  sunset,
  sea,
  mango,
  sky,
  fire,
];
List<Color> sky = [Color(0xFF6448FE), Color(0xFF5FC6FF)];
List<Color> sunset = [Color(0xFFFE6197), Color(0xFFFFB463)];
List<Color> sea = [Color(0xFF61A3FE), Color(0xFF63FFD5)];
List<Color> mango = [Color(0xFFFFA738), Color(0xFFFFE130)];
List<Color> fire = [Color(0xFFFF5DCD), Color(0xFFFF8484)];
//Color.fromRGBO(10, 90, 85, 1);
final drawerColor = Color(0xFF23395d);
final seekBarLight = Color(0xFFB8ECED);
final seekBarDark = Color(0xFF37C8DF);
final lightGradient = Color(0xFFc2e9fb);
final darkGradient = Color(0xFFA1C4FD);
const Color lightPrimary = Color.fromRGBO(250, 240, 230, 1);
const Color darkPrimary = Color.fromRGBO(135, 206, 235, 1);
const Color black = Colors.black;
const Color darkShadow = Color.fromRGBO(128, 128, 105, 1);
const Color lightShadow = Color.fromRGBO(210, 230, 201, 1);

const double appPadding = 30;
late Dio dio;