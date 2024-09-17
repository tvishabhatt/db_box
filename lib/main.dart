import 'package:db_box/Controller/ThemeController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'View/Splace_Screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ThemeController(),),
  ],child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    final themeController=Provider.of<ThemeController>(context);
    return MaterialApp(
      title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
      theme:themeController.isDarkTheme ?ThemeData.dark():ThemeData.light(),

      home: Splace_Screen(),
    );
  }
}


