import 'package:flutter/material.dart';

class Utils{
  static double width(BuildContext context){
    return MediaQuery.of(context).size.width/375;
    // return MediaQuery.of(context).size.width/430;
  }
  static double height(BuildContext context){
    return MediaQuery.of(context).size.height/812;
    // return MediaQuery.of(context).size.height/932;
  }
}