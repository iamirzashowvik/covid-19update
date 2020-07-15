import 'package:flutter/material.dart';
import 'welcome.dart';
import 'data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RestartWidget(
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
            primaryColor: Color(0xFF42224A),
            scaffoldBackgroundColor: Color(0xFF0A0E21)),
        home: PriceScreen(),
      ),
    );
  }
}
