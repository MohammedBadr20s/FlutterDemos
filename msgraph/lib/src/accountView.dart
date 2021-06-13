import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:msgraph/src/models/accountModel.dart';

class AccountView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
   AccountModel _accountData = AccountModel();

  @override
  void initState() {
    // TODO: implement initState
    _getMeData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height: 20),
            Text(
                _accountData.name != null ? _accountData.name : "",
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black
                )
            ),
            Container(height: 20),            Text(
                _accountData.email != null ? _accountData.email : "",
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black
                )
            ),
            Container(height: 20),
            TextButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.black)))),
              onPressed: _logout,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text('Log out',
                    style: TextStyle(color: Colors.black, fontSize: 10)),
              ),
            )
          ],
        ),
      ),
    );
  }

  static const channel = const MethodChannel('ms_graph');

  Future<AccountModel> _getMeData() async {
    AccountModel accountData = AccountModel();
    try {
      var result = await channel.invokeMethod('getMe');
      accountData = AccountModel.fromJson(result);
    } on PlatformException catch (error) {
      print("Failed to get User: '${error.message}");
    }
    setState(() {
      _accountData = accountData;
    });
  }

  Future<void> _logout() async {
    try {
      var result = await channel.invokeMethod('logout');

      Navigator.of(context).popUntil((route) => route.isFirst);
    } on PlatformException catch (error) {
      print("Failed to log out: '${error.message}");
    }
  }
}
