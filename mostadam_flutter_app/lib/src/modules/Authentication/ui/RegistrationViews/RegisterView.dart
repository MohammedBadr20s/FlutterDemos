import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mostadam_flutter_app/src/components/AppLocalizations.dart';
import 'package:mostadam_flutter_app/src/components/Constants.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/bloc/register_bloc.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/ui/RegistrationViews/AccountDataContainer.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/ui/RegistrationViews/ScieneCertificatesView.dart';


import 'PrimaryDateContainer.dart';

class RegisterView extends StatefulWidget {
  final RegisterBloc registerBloc;

  RegisterView({this.registerBloc});

  @override
  RegisterViewState createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView>
    with SingleTickerProviderStateMixin {

  static TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    widget.registerBloc.init();
    super.initState();
    tabController = new TabController(length: 3, vsync: this);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    widget.registerBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // "register_first_tab": "Primary",
    // "register_first_tab_des": "Data",
    // "register_second_tab": "Science",
    // "register_second_tab_des": "Certificates",
    // "register_third_tab": "Account",
    // "register_third_tab_des": "Data"
    return Scaffold(
      appBar: AppBar(
        title: Text(getLocalizedText(context, "regitser_title")),
        centerTitle: true,
        backgroundColor: mostadamTintColor(),
        bottom: PreferredSize(
          preferredSize: new Size(size.width, 100),
          child: MostadamTabBar(size: size),
        ),
      ),
      body: BlocProvider<RegisterBloc>(
        create: (context) => widget.registerBloc,
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            PrimaryDataContainer(size: size, registerBloc: widget.registerBloc),
            ScienceCertificatesView(size: size, registerBloc: widget.registerBloc),
            AccountDataContainer(size: size, registerBloc: widget.registerBloc)
          ],
        ),
      ),
    );
  }
}



class MostadamTabBar extends StatelessWidget {
  const MostadamTabBar({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  "${getLocalizedText(context, "register_first_tab")}",
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
                ),
                Text(
                  "${getLocalizedText(context, "register_first_tab_des")}",
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                      color: Colors.white),
                )
              ],
            ),
            Text(" ----------- ", style: TextStyle(color: Colors.white)),
            Column(
              children: [
                Text(
                  "${getLocalizedText(context, "register_second_tab")}",
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
                ),
                Text(
                  "${getLocalizedText(context, "register_second_tab_des")}",
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                      color: Colors.white),
                )
              ],
            ),
            Text(
              " ----------- ",
              style: TextStyle(color: Colors.white),
            ),
            Column(
              children: [
                Text(
                  "${getLocalizedText(context, "register_third_tab")}",
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
                ),
                Text(
                  "${getLocalizedText(context, "register_third_tab_des")}",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.normal,
                      fontSize: 13,
                      color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
