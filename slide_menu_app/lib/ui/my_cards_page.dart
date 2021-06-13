import 'package:flutter/material.dart';
import 'package:slide_menu_app/bloc/navigation_bloc.dart';


class MyCardsPage extends StatelessWidget with NavigationStates {

  final Function onMenuTap;

  const MyCardsPage({Key key, this.onMenuTap}): super (key : key);

  @override
  Widget build(BuildContext context) {
    // backgroundColor = Colors.blue[700];
    return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    physics: ClampingScrollPhysics(),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Colors.blue[700]
      ),
      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              InkWell(child: Icon(Icons.menu, color: Colors.white, size: 35),
                onTap: () {
                  onMenuTap();
                },
              ),
              Text("My Cards",
                  style: TextStyle(fontSize: 25, color: Colors.white)),
              Icon(Icons.settings, color: Colors.white, size: 35)
            ],
          ),
          SizedBox(height: 50),
          Container(
            height: 200,
            child: PageView(
              controller: PageController(viewportFraction: 0.9),
              scrollDirection: Axis.horizontal,
              pageSnapping: true,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  color: Colors.redAccent,
                  width: 100,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  color: Colors.blueAccent,
                  width: 100,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  color: Colors.greenAccent,
                  width: 100,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text("Transactions",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
              )
          ),
          SizedBox(height: 5),
          ListView.separated(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text("Macbook",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          letterSpacing: 2.0
                      ),
                    ),
                    subtitle: Text("Apple",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          letterSpacing: 2.0
                      ),
                    ),
                    trailing: Text("-2900",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          letterSpacing: 2.0
                      ),
                    )

                );
              }, separatorBuilder: (context, index) {
            return Divider(height: 16);
          }, itemCount: 20)
        ],
      ),
    ),
    );
  }
}
