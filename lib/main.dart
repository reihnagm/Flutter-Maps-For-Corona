import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/hospital.dart';
import './utils/routes.dart';


import 'colors/const.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value (
      value: Hospital(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Maps for Corona',
        theme: ThemeData(
          primaryColor: primaryColor,
          accentColor: accentColor,
        ),
          initialRoute: '/',
          routes: appRoutes,
      ),
    );
  } 
}