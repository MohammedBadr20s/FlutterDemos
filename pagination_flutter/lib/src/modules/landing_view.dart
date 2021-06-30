



import 'package:flutter/material.dart';

class LandingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, 'transaction_view');
                    }, label: Text('المدفوعات',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      )
                  ),
                    icon: Icon(Icons.payment, color: Colors.black),
                  ),
                  Container(height: 10),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, 'charts_view');
                    }, label: Text('الرسومات',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      )
                  ),
                    icon: Icon(Icons.add_chart, color: Colors.black),
                  ),
                  Container(height: 10),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, 'date_picker');
                    }, label: Text('التقويم الهجري',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      )
                  ),
                    icon: Icon(Icons.event, color: Colors.black),
                  ),
                  Container(height: 10),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, 'file_picker');
                    }, label: Text('File Picker',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      )
                  ),
                    icon: Icon(Icons.add_chart, color: Colors.black),
                  ),
                  Container(height: 10),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, 'receipt_view');
                    }, label: Text('Receipt View',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      )
                  ),
                    icon: Icon(Icons.image, color: Colors.black),
                  ),
                  Container(height: 10),
                  // TextButton.icon(
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, 'file_picker');
                  //   }, label: Text('File Picker',
                  //     style: TextStyle(
                  //         fontSize: 17,
                  //         color: Colors.black,
                  //         fontWeight: FontWeight.bold
                  //     )
                  // ),
                  //   icon: Icon(Icons.add_chart, color: Colors.black),
                  // ),
                  // Container(height: 10),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
