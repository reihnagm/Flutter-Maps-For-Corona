import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../screens/home_screen.dart';

class RootScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 600,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      alignment: Alignment(0, 1),
                      image: AssetImage('assets/images/home-background.png'),
                      fit: BoxFit.fitWidth
                    )
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 90),
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/logo/cx_corona_logo.png"),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 450,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Lawan Corona', 
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 1.50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            launch("tel://119");
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.phone, 
                                color: Colors.white,
                                size: 50,
                              ),
                              SizedBox(height: 5),
                              Text('HOTLINE', 
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                                )
                              ),
                              SizedBox(height: 5),
                              Text('119',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                )
                              );
                            },
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.map, 
                                color: Colors.white,
                                size: 50,
                              ),
                              SizedBox(height: 5),
                              Text('RUMAH', 
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                                )
                              ),
                              Text('SAKIT', 
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                                )
                              ),
                            ],
                          ),
                        ),
                      )
                    ], 
                  )
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}