



import 'package:flutter/material.dart';
import 'package:mostadam_flutter_app/src/components/AppLocalizations.dart';
import 'package:mostadam_flutter_app/src/components/Constants.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(getLocalizedText(context, "home") ?? "الصفحة الرئيسية"),
          centerTitle: true,
          backgroundColor: mostadamTintColor(),
        ),
      body: Container(
        color: mostadamTintColor(),
    ),
    );
  }
}
