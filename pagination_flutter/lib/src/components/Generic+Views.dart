import 'package:flutter/material.dart';






class CustomAppText extends StatelessWidget {
  final String title;
  final double fontSize;
  final Color fontColor;
  final TextAlign textAlign;
  final Color backgroundColor;
  final bool showUnderLine;
  final FontWeight fontWeight;

  const CustomAppText({Key key,
    this.title,
    this.fontSize,
    this.fontColor = Colors.white,
    this.textAlign = TextAlign.center,
    this.backgroundColor,
    this.fontWeight = FontWeight.normal,
    this.showUnderLine = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 1),
      decoration: showUnderLine
          ? BoxDecoration(
          border: Border(
              bottom: BorderSide(
                color: fontColor,
                width: 1.0, // Underline thickness
              )))
          : null,
      child: Text(
        title,
        style: TextStyle(
            fontFamily: "Cairo",
            fontWeight: fontWeight,
            fontSize: fontSize,
            color: fontColor,
            backgroundColor: backgroundColor),
        textAlign: textAlign,
      ),
    );
  }
}