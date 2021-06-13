import 'dart:ffi';

import 'package:flutter/material.dart';
import 'AppLocalizations.dart';
import 'Constants.dart';
import 'utils.dart';

class CustomAppText extends StatelessWidget {
  final String localizedKey;
  final String placeHolder;
  final double fontSize;
  final Color fontColor;
  final TextAlign textAlign;
  final Color backgroundColor;
  final bool showUnderLine;

  const CustomAppText({Key key,
    this.localizedKey,
    this.placeHolder,
    this.fontSize,
    this.fontColor = Colors.white,
    this.textAlign = TextAlign.center,
    this.backgroundColor,
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
        getLocalizedText(context, localizedKey) ?? placeHolder,
        style: TextStyle(
            fontFamily: "Cairo",
            fontWeight: FontWeight.normal,
            fontSize: fontSize,
            color: fontColor,
            backgroundColor: backgroundColor),
        textAlign: textAlign,
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final List<BoxShadow> boxShadowList;
  final bool showError;
  final String errorMsg;

  const TextFieldContainer(
      {Key key, this.child, this.boxShadowList, this.showError = false, this.errorMsg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          width: size.width * 0.85,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: boxShadowList ?? []),
          child: child,

        ),
        Visibility(
            visible: showError,
            child: Container(
              width: size.width * 0.8,
              child: CustomAppText(localizedKey: '',
                  placeHolder: errorMsg,
                  fontColor: Colors.red,
                  textAlign: getCurrentLocale(context).languageCode == 'ar'
                      ? TextAlign.right :
                  TextAlign.left),
            )
        )
      ],
    );
  }
}

class RegistrationTextFieldContainer extends StatelessWidget {
  final Widget child;
  final List<BoxShadow> boxShadowList;
  final bool showError;
  final String errorMsg;
  final double height;

  const RegistrationTextFieldContainer(
      {Key key, this.child, this.boxShadowList, this.showError = false, this.errorMsg, this.height = 40})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
          width: size.width * 0.85,
          height: height,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: boxShadowList ?? []),
          child: child,

        ),
        Visibility(
            visible: showError,
            child: Container(
              width: size.width * 0.8,
              child: CustomAppText(localizedKey: '',
                  placeHolder: errorMsg,
                  fontColor: Colors.red,
                  textAlign: getCurrentLocale(context).languageCode == 'ar'
                      ? TextAlign.right :
                  TextAlign.left),
            )
        )
      ],
    );
  }
}

//MARK:- Shadowed Container
class ShadowedContainer extends StatelessWidget {
  final Widget child;
  final double margin;

  const ShadowedContainer({
    Key key,
    @required this.size,
    this.child,
    this.margin = 20,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size.height,
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 0))
          ]),
      child: child,
    );
  }
}

BoxShadow buildMostadamBoxShadow() {
  return BoxShadow(
      color: Colors.grey.withOpacity(0.2),
      spreadRadius: 3,
      blurRadius: 3,
      offset: Offset(0, -2));
}

class MostadamRegistrationTextField extends StatelessWidget {
  final Size size;
  final String initialValue;
  final String localizedKey;
  final String defaultValue;
  final bool enabled;
  final bool showLabel;
  final bool showBorder;
  final bool showShadow;
  final String errorMsg;
  FormFieldValidator<String> validator;
  ValueChanged<String> onChanged;
  TextInputType keyboardType;
  TextEditingController myController = TextEditingController();
  MostadamRegistrationTextField({this.size,
    this.initialValue,
    this.localizedKey,
    this.defaultValue,
    this.errorMsg,
    this.enabled = true,
    this.showBorder = false,
    this.showShadow = false,
    this.showLabel,
    this.validator,
    this.onChanged,
    this.keyboardType});

  @override
  Widget build(BuildContext context) {
    myController.text = initialValue;
    return Column(
      children: [
        Visibility(
          visible: showLabel,
          child: Container(
            width: size.width * 0.85,
            child: CustomAppText(
                localizedKey: localizedKey,
                placeHolder: defaultValue,
                fontSize: 13,
                fontColor: mostadamTintColor(),
                textAlign: getCurrentLocale(context).languageCode == "ar"
                    ? TextAlign.right
                    : TextAlign.left),
          ),
        ),
        SizedBox(height: 5),
        Container(
          width: size.width * 0.85,
          padding: EdgeInsets.all(10),
          child: TextFormField(
            controller: myController,
            // initialValue: initialValue,
            enabled: enabled,
            keyboardType: keyboardType,
            style: TextStyle(
                fontFamily: "Cairo", fontSize: 15, color: Colors.black),
            decoration: InputDecoration(
                isDense: true,
                hintText:
                getLocalizedText(context, localizedKey) ?? defaultValue,
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontFamily: "Cairo",
                  fontSize: 15,
                ),
                contentPadding: EdgeInsets.all(4),
                errorStyle: TextStyle(fontSize: 12, height: 0.3),
                errorText: errorMsg,
                border: showBorder
                    ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(size.width / 2),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                )
                    : InputBorder.none),
            onChanged: onChanged,
            validator: validator,
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(size.width / 2)),
              boxShadow: showShadow ? [buildMostadamBoxShadow()] : []),
        )
      ],
    );
  }
}

class MostadamUploadButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String localizedKey;
  final String defaultValue;
  final String value;
  final bool showError;
  final String errorMsg;

  const MostadamUploadButton({
    Key key,
    this.onPressed,
    this.localizedKey,
    this.defaultValue,
    this.value = "",
    this.showError = false,
    this.errorMsg = ""
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                // side: BorderSide(color: Colors.grey)
              )),
          overlayColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.grey[100];
            }
            return null;
          })),
      child: Stack(
        children: <Widget>[
          Align(
              alignment: getCurrentLocale(context).languageCode == "ar"
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Icon(Icons.attach_file_rounded, color: Colors.black)),
          Align(
              alignment: getCurrentLocale(context).languageCode == "ar"
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomAppText(
                            placeHolder: value.isEmpty ? defaultValue : value,
                            localizedKey: value.isEmpty ? localizedKey : value,
                            fontColor: Colors.black,
                            textAlign:
                            getCurrentLocale(context).languageCode == "ar"
                                ? TextAlign.right
                                : TextAlign.left),
                        Visibility(
                            visible: showError,
                            child: CustomAppText(
                                placeHolder: errorMsg,
                                localizedKey: "",
                                fontColor: Colors.red,
                                textAlign:
                                getCurrentLocale(context).languageCode == "ar"
                                    ? TextAlign.right
                                    : TextAlign.left,
                                fontSize: 13)
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(height: 0.5, color: Colors.grey)
                ],
              ))
        ],
      ),
    );
  }
}

class IconWithDescriptionLayout extends StatelessWidget {
  const IconWithDescriptionLayout({Key key,
    @required this.size,
    this.localizedKey,
    this.defaultValue,
    this.icon,
    this.iconLocalizedTitle,
    this.iconTitleDefaultValue,
    this.backgroundColor,
    this.showDesc = true,
    this.iconTitleFontSize = 16,
    this.iconTitleFontWeight = FontWeight.w600,
    this.showShadow = true})
      : super(key: key);

  final Size size;
  final String localizedKey;
  final String defaultValue;
  final Icon icon;
  final String iconLocalizedTitle;
  final String iconTitleDefaultValue;
  final Color backgroundColor;
  final bool showDesc;
  final double iconTitleFontSize;
  final FontWeight iconTitleFontWeight;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.9,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            width: size.width * 0.9,
            child: RichText(
                text: TextSpan(children: [
                  WidgetSpan(
                      child: icon, alignment: PlaceholderAlignment.middle),
                  TextSpan(
                    text: getLocalizedText(context, iconLocalizedTitle) ??
                        iconTitleDefaultValue,
                    style: TextStyle(
                      fontFamily: "Cairo",
                      fontWeight: iconTitleFontWeight,
                      fontSize: iconTitleFontSize,
                      color: mostadamTextdarkBlueColor(),
                    ),
                  )
                ]),
                textAlign: getCurrentLocale(context).languageCode == "ar"
                    ? TextAlign.right
                    : TextAlign.left),
          ),
          Visibility(
            visible: showDesc,
            child: CustomAppText(
              localizedKey: localizedKey,
              placeHolder: defaultValue,
              fontSize: 14,
              fontColor: mostadamTextdarkBlueColor(),
              textAlign: getCurrentLocale(context).languageCode == "ar"
                  ? TextAlign.right
                  : TextAlign.left,
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: backgroundColor,
          boxShadow: showShadow
              ? [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 0))
          ]
              : []),
    );
  }
}
