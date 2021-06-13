


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:msgraph/src/models/EmailsModel.dart';

class EmailsView extends StatefulWidget {
  @override
  _EmailsViewState createState() => _EmailsViewState();
}

class _EmailsViewState extends State<EmailsView> {
  List<EmailsModel> items = [];

  @override
  void initState() {
    // TODO: implement initState
    _getEmailsData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return buildCell(context, index);
          },
        ),
      ),
    );
  }

  Widget buildCell(BuildContext context, int index) {
    return EmailCell(model: items[index]);
  }

  static const channel = const MethodChannel('ms_graph');

  Future<EmailsModel> _getEmailsData() async {
    List<EmailsModel> emailsData = [];
    try {
      List<dynamic> result = await channel.invokeMethod('getEmails');
      emailsData = result.map((value) => EmailsModel.fromJson(value)).toList();
    } on PlatformException catch (error) {
      print("Failed to get User: '${error.message}");
    }
    setState(() {
      items = emailsData;
    });
  }
}
class EmailCell extends StatelessWidget {

  EmailCell({this.model});

  final EmailsModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 10),
          Text(model.sender),
          Container(height: 10),
          Text(model.subject),
          Container(height: 10),
          Text(model.body),
          Container(height: 1, color: Colors.grey[200]),
          Container(height: 20),
        ],
      ),
    );
  }
}