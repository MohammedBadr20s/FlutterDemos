import 'package:flutter/material.dart';
import 'package:slide_menu_app/bloc/navigation_bloc.dart';


class MessagesPage extends StatelessWidget with NavigationStates {
  final Function onMenuTap;

  const MessagesPage({Key key, this.onMenuTap}): super (key : key);

  @override
  Widget build(BuildContext context) {
    // backgroundColor = Colors.red;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.red
      ),
      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(
              child: Icon(Icons.menu, color: Colors.white, size: 35),
              onTap: () {
                onMenuTap();
              },
            ),
            Text("Messages",
                style: TextStyle(fontSize: 25, color: Colors.white)),
            Icon(Icons.settings, color: Colors.white, size: 35)
          ],
        ),
      ]),
    );
  }
}
