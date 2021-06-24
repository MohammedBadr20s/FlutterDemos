


import 'package:flutter/material.dart';
import 'package:hijri_picker/hijri_picker.dart';
import 'package:hijri/hijri_calendar.dart';


class HijriDatePicker extends StatefulWidget {
  final String title;
  HijriDatePicker({this.title = "التاريخ أم القرى"});

  @override
  _HijriDatePickerState createState() => _HijriDatePickerState();
}

class _HijriDatePickerState extends State<HijriDatePicker> {
  var selectedDate = new HijriCalendar.now();

  @override
  Widget build(BuildContext context) {
    HijriCalendar.setLocal(Localizations.localeOf(context).languageCode);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Text(
                '${selectedDate.toString()}',
                style: Theme.of(context).textTheme.headline5,
              ),
              new Text(
                '${selectedDate.fullDate()}',
                style: Theme.of(context).textTheme.headline5,
              ),

            ],
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => _selectDate(context),
        backgroundColor: Colors.black,
        tooltip: 'Pick Date',
        child: new Icon(Icons.event),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final HijriCalendar picked = await showHijriDatePicker(
      context: context,
      initialDate: selectedDate,

      lastDate: new HijriCalendar()
        ..hYear = 1500
        ..hMonth = 12
        ..hDay = 25,
      firstDate: new HijriCalendar()
        ..hYear = 1438
        ..hMonth = 12
        ..hDay = 25,
      initialDatePickerMode: DatePickerMode.day,
    );
    if (picked != null)
      setState(() {
        selectedDate = picked;
      });
  }
}
