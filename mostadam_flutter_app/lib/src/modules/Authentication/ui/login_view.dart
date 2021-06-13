import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mostadam_flutter_app/src/components/AppLocalizations.dart';
import 'package:mostadam_flutter_app/src/components/Constants.dart';
import 'package:mostadam_flutter_app/src/components/GenericViews.dart';
import 'package:mostadam_flutter_app/src/components/StateViews.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/bloc/login_bloc.dart';
import 'package:formz/formz.dart';

class LoginView extends StatefulWidget {
  final LoginBloc bloc;

  LoginView({this.bloc});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
   listenAndNavigate(BuildContext context, LoginState state) {
     switch (state.loginStatus) {
       case LoginStatus.authenticated:
         print("Login Success");
         Navigator.pushNamed(context, '/home');
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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider<LoginBloc>(
      create: (context) => widget.bloc,
      child: Scaffold(
          body: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return loginBody(size);
            }
          )),
    );
  }

  Stack loginBody(Size size) {
    return Stack(children: [
      Container(
            width: double.infinity,
            height: size.height,
            color: mostadamTintColor(),
            child: BlocListener<LoginBloc, LoginState>(
              listener: listenAndNavigate,
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(height: 80),
                      Container(
                          width: 200,
                          height: 80,
                          color: Colors.white,
                          child: Image.asset(
                            ImagePaths.shared.mostadamLogo,
                            fit: BoxFit.fitWidth,
                          )),
                      Text(
                        "تسجيل دخول",
                        style: TextStyle(
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.w400,
                            fontSize: 30),
                      ),
                      Container(
                        width: size.width * 0.1,
                        height: 4,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                      ),
                      Container(
                        height: 50,
                      ),
                      LoginFieldsLayout(size: size, bloc: widget.bloc)
                    ],
                  ),
                ),
              ),
            ),
      ),
      BlocBuilder<LoginBloc, LoginState>(
              builder:  (context, state) {
                return Visibility(
                    visible: (state is LoadingState)
                        ? true
                        : false,
                    child: Center(child: Loading(loadingMessage: "")));
              })
    ]);
  }
}

class LoginFieldsLayout extends StatelessWidget {
  const LoginFieldsLayout({
    Key key,
    @required this.size,
    @required this.bloc,
  }) : super(key: key);

  final Size size;
  final LoginBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: size.width,
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Column(
            children: [
              Container(height: 50),
              Container(
                  width: size.width,
                  decoration: BoxDecoration(
                      color: mostadamTintColor(),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                  child: LoginLayout(size: size, bloc: bloc)),
            ],
          ),
        ),
        EngineerIcon()
      ],
    );
  }
}

class EngineerIcon extends StatelessWidget {
  const EngineerIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50)),
          // border: Border.all(color: Colors.black, width: 1)
        ),
        child: Image.asset(
          ImagePaths.shared.loginEngineerPic,
          fit: BoxFit.fitWidth,
        ));
  }
}

class LoginLayout extends StatelessWidget {
  const LoginLayout({Key key, @required this.size, @required this.bloc})
      : super(key: key);

  final Size size;
  final LoginBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(height: 50),
        BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (previous, current) => previous.username != current.username,
              builder: (context, state) {
                return TextFieldContainer(
                  showError: state.username.invalid,
                  errorMsg: state.username.error,
                  child: TextField(
                    decoration: InputDecoration(
                        isCollapsed: true,
                        prefixIcon: Icon(Icons.person_outline,
                            color: mostadamTintColor()),
                        hintText:
                            getLocalizedText(context, "username_placeholder"),
                        border: InputBorder.none,
                        // errorText: state.username.invalid ? 'يجب كتابة اسم المستخدم': null,
                        contentPadding: EdgeInsets.only(top: 5)),
                    onChanged: (username) => context.read<LoginBloc>().add(UserNameChanged(username: username)),
                  ),
                );
              }),
        BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (previous, current) => previous.password != current.password,
              builder: (context, state) {
                return TextFieldContainer(
                  showError: state.password.invalid,
                  errorMsg: state.password.error,
                  child: TextField(
                    decoration: InputDecoration(
                        isCollapsed: true,
                        prefixIcon:
                            Icon(Icons.lock_outline, color: mostadamTintColor()),
                        hintText:
                            getLocalizedText(context, "password_placeholder"),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 5)),
                    onChanged: (password) => context.read<LoginBloc>().add(PasswordChanged(password: password)),
                  ),
                );
              }),
        Container(
            width: size.width * 0.8,
            child: CustomAppText(
                localizedKey: "password_sensitive",
                placeHolder: "كلمة المرور حساسة لحالة ",
                fontSize: 12)),
        Container(
          height: 40,
        ),
        TextButton(
          onPressed: () {
            //Navigate to Forget Password Screen
            Navigator.pushNamed(context, '/forget_password');
          },
          child: CustomAppText(
              localizedKey: "forget_password",
              placeHolder: "نسيت كلمة المرور ؟"),
        ),
        SizedBox(
          width: size.width * 0.8,
          height: 40,
          child: BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (previous, current) => previous.status != current.status,
              builder: (context, state) {
                return ElevatedButton(
                    onPressed: state.status.isValidated
                        ? () {
                            context.read<LoginBloc>().add(LoginRequestEvent());
                          }
                        : null,
                    child: Text(
                      getLocalizedText(context, "login_view") ?? "تسجيل دخول",
                      style: TextStyle(
                          fontFamily: "Cairo",
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
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
                          else if (states.contains(MaterialState.disabled))
                            return mostadamButtonBackgroundColor().withOpacity(0.7);
                          return mostadamButtonBackgroundColor(); // Use the component's default.
                        }),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                // side: BorderSide(color: Colors.red)
                            )
                        ),
                    )
                );
              }),
        ),
        Container(
          height: 40,
        ),
        CustomAppText(
            localizedKey: "dont_have_account",
            placeHolder: "اذا كنت لا تمتلك حسابًا بعد"),
        SizedBox(
          width: size.width * 0.8,
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              //Register Action
              Navigator.pushNamed(context, 'register');
            },
            child: Text(
              getLocalizedText(context, "create_account") ?? "إنشاء حساب جديد",
              style: TextStyle(
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
                primary: mostadamTintColor(),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20),
                ),
                side: BorderSide(color: Colors.white, width: 0.5),
                elevation: 0),
          ),
        ),
        Container(height: 100)
      ],
    );
  }
}
