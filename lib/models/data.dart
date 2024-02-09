import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

List<String> comboboxtype = [];
List<String> comboboxproduct = [];
List<String> combobox = [];
List<CameraDescription> camerasg = <CameraDescription>[];

const String Build = "1";
const String Major = "5";
const String Minor = "0";

const String devurl = "http://127.0.0.1:5000/";
const String produrl = "http://dafageraldine.pythonanywhere.com/";
String baseurl = produrl;

//for color
Color theme = const Color.fromRGBO(144, 200, 172, 1);
Color themewithopacity = const Color.fromRGBO(144, 200, 172, 0.3);
Color err = const Color.fromRGBO(244, 67, 54, 1);
Color errwithopacity = const Color.fromRGBO(244, 67, 54, 0.3);
Color sucs = const Color.fromRGBO(76, 175, 80, 1);
Color sucswithopacity = const Color.fromRGBO(76, 175, 80, 0.3);
Color warn = const Color.fromRGBO(255, 235, 59, 1);
Color warnwithopacity = const Color.fromRGBO(255, 235, 59, 0.3);
