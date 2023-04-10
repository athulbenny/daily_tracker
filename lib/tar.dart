//import 'dart:ffi';

import 'package:flutter/material.dart';
/*
class Target extends StatefulWidget {
  const Target({Key? key, required this.tar}) : super(key: key);
  final String tar;
  @override
  State<Target> createState() => _TargetState();
}

class _TargetState extends State<Target> {
  late String tar= this.tar;
  final li=<String>[];
  @override
  li.add(tar);
  Widget build(BuildContext context) {
    return Container(
      child: Text(tar),);
  }
}*/



class Target extends StatelessWidget {
   Target({Key? key,required this.li,required this.index}) : super(key: key);
  //final String tar;
  List li;int index;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: ListView.builder(itemCount: 1,itemBuilder: (BuildContext context,ind){
      return li[ind];
    }),);
  }
}


