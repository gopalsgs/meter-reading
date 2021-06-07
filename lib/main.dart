import 'package:flutter/material.dart';
import 'package:meter_reading/features/meters_page/meters_page.dart';
import 'package:meter_reading/features/readings_page/readings_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meter Reading',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _index == 0 ? MetersPage() : ReadingsPage(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.access_time,
            ),
            label: 'Meters',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.paste_rounded,
            ),
            label: 'Readings',
          ),
        ],
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
      ),
    );
  }
}
