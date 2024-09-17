import 'package:db_box/View/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
              "what is the use of this app ?",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )),
            SizedBox(
              height: 30,
            ),
            Center(
                child: Text(
              "Write your all Todos in this app And bookmark your favorite Todos . You can also change the theme of app .",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              textAlign: TextAlign.center,
            )),
            SizedBox(
              height: 70,
            ),

            ElevatedButton(
              onPressed: () async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool("intro_is_seen", true);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => home_page(), ));
              },
              child: Text('Next'),
            ),


          ],
        ),
      ),
    );
  }
}
