import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

TextEditingController nameController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController attendController = TextEditingController();
  TextEditingController expectedController = TextEditingController();
  final subjectsBox = Hive.box('subjects');
  final routineBox=Hive.box('routine');
  String subname;
  String name;
  int total,attended,expected,i;

  var date= DateTime.now();

  List mon=[];
  List tue=[];
  List wed=[];
  List thu=[];
  List fri=[];
  List sat=[];
  List sun=[];
  
  List listday=["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"];












