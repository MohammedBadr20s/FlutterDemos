


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:msgraph/src/models/ContactsModel.dart';

class ContactsView extends StatefulWidget {
  @override
  _ContactsViewState createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {

  List<ContactsModel> items = [];

  @override
  void initState() {
    // TODO: implement initState
    _getContactsData();
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
    return ContactCell(model: items[index]);
  }

  static const channel = const MethodChannel('ms_graph');

  Future<ContactsModel> _getContactsData() async {
    List<ContactsModel> emailsData = [];
    try {
      List<dynamic> result = await channel.invokeMethod('getContacts');
      emailsData = result.map((value) => ContactsModel.fromJson(value)).toList();
    } on PlatformException catch (error) {
      print("Failed to get User: '${error.message}");
    }
    setState(() {
      items = emailsData;
    });
  }
}

class ContactCell extends StatelessWidget {

  ContactCell({this.model});

  final ContactsModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 10),
          Text(model.contactName),
          Container(height: 10),
          Text(model.mobile),
          Container(height: 10),
          Container(height: 1, color: Colors.grey[200]),
          Container(height: 20),
        ],
      ),
    );
  }
}