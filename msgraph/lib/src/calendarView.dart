

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:msgraph/src/models/EventsModel.dart';

class CalendarView extends StatefulWidget {
  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  List<EventsModel> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getEventsData();
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
    return EventCell(model: items[index]);
  }

  static const channel = const MethodChannel('ms_graph');

  Future<EventsModel> _getEventsData() async {
    List<EventsModel> eventsData = [];
    try {
      List<dynamic> result = await channel.invokeMethod('getEvents');
      eventsData = result.map((value) => EventsModel.fromJson(value)).toList();
    } on PlatformException catch (error) {
      print("Failed to get User: '${error.message}");
    }
    setState(() {
      items = eventsData;
    });
  }
}
class EventCell extends StatelessWidget {

  EventCell({this.model});

  final EventsModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 10),
          Text(model.subject),
          Container(height: 10),
          Text(model.organizer),
          Container(height: 10),
          Text(model.duration),
          Container(height: 20),
        ],
      ),
    );
  }
}

