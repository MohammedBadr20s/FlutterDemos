import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:msgraph/src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final token = await _getSilentTokenData();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white
  ));
  runApp(App(initialRoute: token.isEmpty ? '/' : '/graphView'));
}


const channel = const MethodChannel('ms_graph');

Future<String> _getSilentTokenData() async {
  String token;
  try {
    var result = await channel.invokeMethod('getSilentToken');
    token = result;
  } on PlatformException catch (error) {
    print("Failed to get token: '${error.message}");
    token = "";
  }
  return token;
}
