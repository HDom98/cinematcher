import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final List colorList = [
  Colors.blue,
  Colors.green,
  Colors.purple,
  Colors.yellow,
  Colors.orange,
  Colors.cyan,
  Colors.tealAccent,
  Colors.grey,
  Colors.lightGreen];

/// Returns a random color. used for the genre picker
Color randColor(){
  return colorList[Random().nextInt(colorList.length-1)];
}