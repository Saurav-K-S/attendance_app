// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:attendance_app/screens/second.dart';
import 'package:attendance_app/screens/third.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());
bool x = false;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  Future<String?> _getSheetId() async {
    final prefs = await SharedPreferences.getInstance();
    // final success = await prefs.remove('sheetId');
    // print(success);
    return prefs.getString('sheetId');
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FutureBuilder(
          future: _getSheetId(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              if (snapshot.data != null || snapshot.data != "") {
                x = true;
                // return subdate();
              } else {
                x = false;
                // return MyHomePage();
              }
            } else {
              // return const Center(child: CircularProgressIndicator());
              return MyHomePage();
            }
            return MyHomePage();
            // return x ? subdate() : MyHomePage();
          },
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe9dac1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                if (x) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return subdate();
                  }));
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SecondPage();
                  }));
                }
              },
              child: Icon(
                Icons.people,
                size: 178,
                color: Color(0xFF18978F),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
