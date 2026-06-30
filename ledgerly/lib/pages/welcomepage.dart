import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ledgerly/pages/Homepgae.dart';

import '../logo/ledgerly_logo.dart';

class welcomepage extends StatefulWidget{
  welcomepage({required this.apptheme,super.key});
  final void Function (String mode) apptheme;
  @override
  State<welcomepage> createState() => _welcomepageState();
}

class _welcomepageState extends State<welcomepage> {
   @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Homepgae(AppTheme: widget.apptheme,)) );
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width =MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: Theme.of(context).primaryColor,
        child: Center(child:  LedgerlyLogo()),
      ),
    );
  }
}
