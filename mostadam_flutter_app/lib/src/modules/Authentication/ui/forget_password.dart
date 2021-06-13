import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mostadam_flutter_app/src/components/AppLocalizations.dart';
import 'package:mostadam_flutter_app/src/components/Constants.dart';
import 'package:mostadam_flutter_app/src/components/GenericViews.dart';
import 'package:mostadam_flutter_app/src/components/StateViews.dart';
import 'package:mostadam_flutter_app/src/components/utils.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/bloc/login_bloc.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/model/forget_password_model.dart';
import 'package:mostadam_flutter_app/src/modules/base/base_model.dart';
import 'package:validators/validators.dart';
import 'package:formz/formz.dart';


class ForgetPassword extends StatefulWidget {
  final LoginBloc bloc;

  ForgetPassword({this.bloc});

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  listenAndNavigate(BuildContext context, LoginState state) {
    final st = (state as ForgetPasswordChangedState);
    switch (st.loginStatus) {
      case LoginStatus.success:
        Fluttertoast.showToast(
            msg: st.forgetPasswordModel.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: mostadamTintColor(),
            textColor: Colors.white,
            fontSize: 16.0);
        break;
      case LoginStatus.error:
        Fluttertoast.showToast(
            msg: (state as LoginError).error.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        break;

      default:
        break;
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(getLocalizedText(context, "forget_password_title") ??
            "إستعادة كلمة المرور"),
        centerTitle: true,
        backgroundColor: mostadamTintColor(),
      ),
      body: BlocProvider<LoginBloc>(
        create: (context) => widget.bloc,
        child: BlocListener<LoginBloc, LoginState>(
          listener: listenAndNavigate,
          child: Stack(children: [
            Container(
              width: double.infinity,
              height: size.height,
              child: Column(
                children: [
                  Container(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: size.width * 0.9,
                    height: size.height * 0.35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 3,
                              offset: Offset(0, 0))
                        ]),
                    child: Column(
                      children: [
                        Container(height: 30),
                        Container(
                          width: size.width * 0.8,
                          child: CustomAppText(
                              localizedKey: "email",
                              placeHolder: "البريد الإلكتروني",
                              fontSize: 17,
                              fontColor: Colors.black,
                              textAlign:
                                  getCurrentLocale(context).languageCode == "ar"
                                      ? TextAlign.right
                                      : TextAlign.left),
                        ),
                        BlocBuilder<LoginBloc, LoginState>(
                          buildWhen: (previous, current) => previous.email != current.email,
                          builder: (context, state) {
                            return TextFieldContainer(
                              showError: state.email.invalid,
                              errorMsg: state.email.error,
                              child: TextField(
                                decoration: InputDecoration(
                                    isCollapsed: true,
                                    hintText: getLocalizedText(
                                        context, "enter_email") ??
                                        "أدخل البريد الإلكتروني",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: 5, right: 5, top: 5)),
                                onChanged: (email) => context.read<LoginBloc>().add(EmailChanged(email: email)),
                              ),
                              boxShadowList: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 3,
                                    blurRadius: 3,
                                    offset: Offset(0, -2))
                              ],
                            );
                          },
                        ),
                        Container(height: 60),
                        SizedBox(
                          width: size.width * 0.8,
                          height: 40,
                          child: BlocBuilder<LoginBloc, LoginState>(
                              buildWhen: (previous, current) => previous.status != current.status,
                              builder: (context, state) {
                                return ElevatedButton(
                                  onPressed: state.status.isValidated
                                      ? () {
                                    //ForgetPassword Action
                                    print("Send Forget Password");
                                    context.read<LoginBloc>().add(ForgetPasswordChanged());
                                  }
                                      : null,
                                  child: Text(
                                    getLocalizedText(context, "send") ?? "إرسال",
                                    style: TextStyle(
                                        fontFamily: "Cairo",
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15,
                                        color: Colors.white),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith<Color>(
                                            (Set<MaterialState> states) {
                                      if (states.contains(MaterialState.pressed))
                                        return Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(0.8);
                                      else if (states
                                          .contains(MaterialState.disabled))
                                        return mostadamButtonBackgroundColor()
                                            .withOpacity(0.7);
                                      return mostadamButtonBackgroundColor(); // Use the component's default.
                                    }),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      // side: BorderSide(color: Colors.red)
                                    )),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return Visibility(
                      visible: (state is LoadingState) ? true : false,
                      child: Center(child: Loading(loadingMessage: "")));
                })
          ]),
        ),
      ),
    );
  }
}
