import 'package:flutter/material.dart';

void main(){
  return runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData(
        colorScheme:  ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 344, 912, 122))
      ),
      home: homepage(),
    );
  }
}
class homepage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Center(
          child: Text("Hello Bro Welcome in Ledgerly ..!",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 25),),
        ),
      ),
    );
  }
}