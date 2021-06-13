import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ContactsView.dart';
import 'EmailsView.dart';
import 'accountView.dart';
import 'calendarView.dart';

class GraphView extends StatefulWidget {
  @override
  _GraphViewState createState() => _GraphViewState();
}

class _GraphViewState extends State<GraphView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('MS Graph'),
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),

        ),
        body: TabBarView(
          children: [
            AccountView(),
            CalendarView(),
            EmailsView(),
            ContactsView()
          ],
        ),
        bottomNavigationBar: Container(
          height: 90,
          color: Colors.grey[300],
          child: Column(
            children: [
              TabBar(
                labelColor: Colors.blueAccent,
                unselectedLabelColor: Colors.grey,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: EdgeInsets.all(5.0),
                indicatorColor: Colors.transparent,
                isScrollable: true,
                tabs: [
                  Tab(icon: Icon(Icons.person), child: Text('My Account', style: TextStyle(color: Colors.black))),
                  Tab(icon: Icon(Icons.calendar_today_rounded), child: Text('Calendar', style: TextStyle(color: Colors.black))),
                  Tab(icon: Icon(Icons.email_rounded), child: Text('Emails', style: TextStyle(color: Colors.black))),
                  Tab(icon: Icon(Icons.group), child: Text('Contacts', style: TextStyle(color: Colors.black))),
                ],
              ),
              Container(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
