import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String _token = "Not authorized yet";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MS Graph Flutter Demo'),
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.black)
                        )
                    )
                ),
                onPressed: _getInterActiveTokenData,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text('Sign in',
                      style: TextStyle(color: Colors.black, fontSize: 25)),
                ),
              ),
              Container(height: 15),
              Text(
                _token == null ? "": _token,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        )
    );
  }
  static const channel = const MethodChannel('ms_graph');

  Future<void> _getInterActiveTokenData() async {
    String token;
    try {
      var result = await channel.invokeMethod('getInterActiveToken');
      token = result;
    } on PlatformException catch (error) {
      token = "Failed to get token: '${error.message}";
    }
    setState(() {
      Navigator.pushNamed(context, '/graphView');
      _token = token;
    });
  }
}
