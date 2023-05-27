import 'package:flutter/material.dart';

List<String> comboboxtype = [];
List<String> comboboxproduct = [];
List<String> combobox = [];

var Build = "1";
var Major = "3";
var Minor = "0";

var devurl = "http://127.0.0.1:5000/";
// var profurl = "http://apirecordinvest.herokuapp.com/";
var profurl = "http://dafageraldine.pythonanywhere.com/";
var baseurl = profurl;

//for color
Color theme = const Color.fromRGBO(144, 200, 172, 1);
Color themewithopacity = const Color.fromRGBO(144, 200, 172, 0.3);
Color err = const Color.fromRGBO(244, 67, 54, 1);
Color errwithopacity = const Color.fromRGBO(244, 67, 54, 0.3);
Color sucs = const Color.fromRGBO(76, 175, 80, 1);
Color sucswithopacity = const Color.fromRGBO(76, 175, 80, 0.3);
Color warn = const Color.fromRGBO(255, 235, 59, 1);
Color warnwithopacity = const Color.fromRGBO(255, 235, 59, 0.3);
