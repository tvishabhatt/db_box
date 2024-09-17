import 'dart:async';

import 'package:db_box/View/IntroPage.dart';
import 'package:db_box/View/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splace_Screen extends StatefulWidget {
  const Splace_Screen({Key? key}) : super(key: key);

  @override
  State<Splace_Screen> createState() => _Splace_ScreenState();
}

class _Splace_ScreenState extends State<Splace_Screen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool seen = prefs.getBool('intro_is_seen') ?? false;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>    (seen)?home_page():IntroPage(),));
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 400,),
              Center(child: Text("TODO APP",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)),
              Expanded(child: SizedBox()),
              Text("Made in India with ❤️ .",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18)),
              SizedBox(height: 30,),
            ],
          ),
        ),

      );
  }
}

