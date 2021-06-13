import 'package:flutter/material.dart';
import 'package:slide_menu_app/menu_dashboard_layout/menu_dashboard_layout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Slide Menu Demo",
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: MenuDashboardLayout(),
    );
  }
}
