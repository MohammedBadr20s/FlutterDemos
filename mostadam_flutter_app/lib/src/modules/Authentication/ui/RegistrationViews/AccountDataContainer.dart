import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mostadam_flutter_app/src/components/AppLocalizations.dart';
import 'package:mostadam_flutter_app/src/components/Constants.dart';
import 'package:mostadam_flutter_app/src/components/GenericViews.dart';
import 'package:mostadam_flutter_app/src/components/StateViews.dart';
import 'package:mostadam_flutter_app/src/components/ValidationMixin.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/bloc/register_bloc.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/model/BankDataModel.dart';
import 'package:mostadam_flutter_app/src/modules/base/base_model.dart';
import 'package:validators/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'RegisterView.dart';

class AccountDataContainer extends StatefulWidget {
  final RegisterBloc registerBloc;

  AccountDataContainer({Key key, @required this.size, this.registerBloc})
      : super(key: key);
  final Size size;

  @override
  _AccountDataContainerState createState() => _AccountDataContainerState();
}

class _AccountDataContainerState extends State<AccountDataContainer> {
  final _form = GlobalKey<FormState>();

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
  }

  BankData dropdownValue = BankData(
      id: 0,
      nameAr: 'أسم البنك',
      name: 'أسم البنك',
      nameEn: 'Bank name',
      code: "0");
  bool isSwitched = false;

  @override
  void initState() {
    // TODO: implement initState
    context.read<RegisterBloc>().add(RequestBankData());
    super.initState();
    // widget.registerBloc.registerDataRes.listen((value) {
    //   switch (value.status) {
    //     case Status.LOADING:
    //       break;
    //     case Status.COMPLETED:
    //       Fluttertoast.showToast(
    //           msg: "You Have Registered Successfully ",
    //           toastLength: Toast.LENGTH_SHORT,
    //           gravity: ToastGravity.BOTTOM,
    //           timeInSecForIosWeb: 1,
    //           backgroundColor: Colors.greenAccent,
    //           textColor: Colors.white,
    //           fontSize: 16.0);
    //       break;
    //     case Status.ERROR:
    //       Fluttertoast.showToast(
    //           msg: value.toString(),
    //           toastLength: Toast.LENGTH_SHORT,
    //           gravity: ToastGravity.BOTTOM,
    //           timeInSecForIosWeb: 1,
    //           backgroundColor: Colors.red,
    //           textColor: Colors.white,
    //           fontSize: 16.0);
    //       break;
    //   }
    // });
    // widget.registerBloc.validateBankData.listen((event) {
    //   print("Bank Data is : ${event}");
    // }).onError((Object objc) {
    //   Fluttertoast.showToast(
    //       msg: objc,
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.red,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    // });

  }
  listenAndNavigate(BuildContext context, RegisterState state) {
    if (state is RegisterError) {
      switch (state.registerStatus) {
        case RegisterStatus.authenticated:
          print("Register Success");
          Fluttertoast.showToast(
              msg: "You Have Registered Successfully ",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.greenAccent,
              textColor: Colors.white,
              fontSize: 16.0);
          break;
        case RegisterStatus.error:
          Fluttertoast.showToast(
              msg: (state as RegisterError).error.message,
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

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ShadowedContainer(
        size: widget.size,
        child: Form(
          key: _form,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: BlocListener<RegisterBloc, RegisterState>(
            listener: listenAndNavigate,
            child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    BlocBuilder<RegisterBloc, RegisterState>(
                        builder: (context, state) {
                      return RegistrationTextFieldContainer(
                          showError: widget.registerBloc.registerData.username !=
                                  null
                              ? widget.registerBloc.registerData.username.invalid
                              : false,
                          errorMsg:
                              widget.registerBloc.registerData.username != null
                                  ? widget.registerBloc.registerData.username.error
                                  : null,
                          child: TextField(
                            obscureText: false,
                            onChanged: (userName) => context
                                .read<RegisterBloc>()
                                .add(UserNameChanged(userName: userName)),
                            decoration: InputDecoration(
                                isCollapsed: true,
                                hintText: getLocalizedText(
                                        context, "username_placeholder") ??
                                    "أسم المستخدم",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: "Cairo",
                                  fontSize: 15,
                                ),
                                contentPadding: EdgeInsets.only(left: 5, right: 5),
                                border: InputBorder.none),
                          ),
                          boxShadowList: [buildMostadamBoxShadow()]);
                    }),
                    SizedBox(height: 10),
                    BlocBuilder<RegisterBloc, RegisterState>(
                        builder: (context, state) {
                      return RegistrationTextFieldContainer(
                          showError: widget.registerBloc.registerData.email != null
                              ? widget.registerBloc.registerData.email.invalid
                              : false,
                          errorMsg: widget.registerBloc.registerData.email != null
                              ? widget.registerBloc.registerData.email.error
                              : null,
                          child: TextField(
                            obscureText: false,
                            onChanged: (email) => context
                                .read<RegisterBloc>()
                                .add(EmailChanged(email: email)),
                            decoration: InputDecoration(
                                isCollapsed: true,
                                hintText: getLocalizedText(context, "email") ??
                                    "البريد الإلكتروني",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: "Cairo",
                                  fontSize: 15,
                                ),
                                contentPadding: EdgeInsets.only(left: 5, right: 5),
                                border: InputBorder.none),
                          ),
                          boxShadowList: [buildMostadamBoxShadow()]);
                    }),
                    SizedBox(height: 10),
                    BlocBuilder<RegisterBloc, RegisterState>(
                        builder: (context, state) {
                      return RegistrationTextFieldContainer(
                          showError: (widget.registerBloc.registerData.email != null && widget.registerBloc.registerData.confirmEmail != null)
                              ? widget.registerBloc.registerData.email.value != widget.registerBloc.registerData.confirmEmail.value
                              : false,
                          errorMsg: "رجاءالتأكد من صحة البريد الإلكتروني",
                          child: TextField(
                            obscureText: false,
                            onChanged: (confirmEmail) => context
                                .read<RegisterBloc>()
                                .add(ConfirmEmailChanged(
                                    confirmEmail: confirmEmail)),
                            decoration: InputDecoration(
                                isCollapsed: true,
                                hintText: getLocalizedText(
                                        context, "email_confirmation") ??
                                    "تأكيد البريد الإلكتروني",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: "Cairo",
                                  fontSize: 15,
                                ),
                                contentPadding: EdgeInsets.only(left: 5, right: 5),
                                border: InputBorder.none),
                          ),
                          boxShadowList: [buildMostadamBoxShadow()]);
                    }),
                    SizedBox(height: 10),
                    BlocBuilder<RegisterBloc, RegisterState>(
                        builder: (context, state) {
                          return RegistrationTextFieldContainer(
                              showError: widget.registerBloc.registerData.phoneNumber != null
                                  ? widget.registerBloc.registerData.phoneNumber.invalid
                                  : false,
                              errorMsg: widget.registerBloc.registerData.phoneNumber != null
                                  ? widget.registerBloc.registerData.phoneNumber.error
                                  : null,
                              child: TextField(
                                obscureText: false,
                                onChanged: (phone) => context
                                    .read<RegisterBloc>()
                                    .add(PhoneChanged(phone: phone)),
                                decoration: InputDecoration(
                                    isCollapsed: true,
                                    hintText: getLocalizedText(context, "phone_title") ??
                                        "رقم الجوال",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "Cairo",
                                      fontSize: 15,
                                    ),
                                    contentPadding: EdgeInsets.only(left: 5, right: 5),
                                    border: InputBorder.none),
                              ),
                              boxShadowList: [buildMostadamBoxShadow()]);
                        }),
                    SizedBox(height: 10),
                    BlocBuilder<RegisterBloc, RegisterState>(
                        builder: (context, state) {
                          return RegistrationTextFieldContainer(
                              showError: widget.registerBloc.registerData.password != null
                                  ? widget.registerBloc.registerData.password.invalid
                                  : false,
                              errorMsg: widget.registerBloc.registerData.password != null
                                  ? widget.registerBloc.registerData.password.error
                                  : null,
                              child: Stack(
                                children: [TextField(
                                  obscureText: false,
                                  onChanged: (password) => context
                                      .read<RegisterBloc>()
                                      .add(PasswordChanged(password: password)),
                                  decoration: InputDecoration(
                                      isCollapsed: true,
                                      hintText: getLocalizedText(context, "password_placeholder") ??
                                          "كلمة المرور",
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "Cairo",
                                        fontSize: 15,
                                      ),
                                      contentPadding: EdgeInsets.only(left: 5, right: 5),
                                      border: InputBorder.none),
                                ),
                                  Positioned.fill(
                                      right: 10,
                                      left: 10,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: InkWell(
                                              onTap: () {},
                                              child: Icon(Icons.visibility,
                                                  color: mostadamTintColor()))))
                            ]),
                              boxShadowList: [buildMostadamBoxShadow()]);
                        }),
                    IconWithDescriptionLayout(
                      size: widget.size,
                      showDesc: false,
                      icon: Icon(Icons.info, color: mostadamTintColor()),
                      iconLocalizedTitle: "PASSWORD_DESC",
                      iconTitleDefaultValue:
                          "كلمة المرور لا تقل عن ٨ حروف ولا تزيد عن ٢٥ حرف ولا يقبل النظام كلمات المرور الضعيفة أي يجب ان تتكون من حروف وأرقام",
                      backgroundColor: Colors.white,
                      iconTitleFontSize: 14,
                      iconTitleFontWeight: FontWeight.normal,
                      showShadow: false,
                    ),
                    BlocBuilder<RegisterBloc, RegisterState>(
                        builder: (context, state) {
                          return RegistrationTextFieldContainer(
                              showError: widget.registerBloc.registerData.confirmPassword != null
                                  ? widget.registerBloc.registerData.confirmPassword.invalid
                                  : false,
                              errorMsg: widget.registerBloc.registerData.confirmPassword != null
                                  ? widget.registerBloc.registerData.confirmPassword.error
                                  : null,
                              child: Stack(
                                  children: [TextField(
                                    obscureText: false,
                                    onChanged: (password) => context
                                        .read<RegisterBloc>()
                                        .add(ConfirmPasswordChanged(
                                        confirmPassword: password)),
                                    decoration: InputDecoration(
                                        isCollapsed: true,
                                        hintText: getLocalizedText(context, "password_placeholder") ??
                                            "كلمة المرور",
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "Cairo",
                                          fontSize: 15,
                                        ),
                                        contentPadding: EdgeInsets.only(left: 5, right: 5),
                                        border: InputBorder.none),
                                  ),
                                    Positioned.fill(
                                        right: 10,
                                        left: 10,
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: InkWell(
                                                onTap: () {},
                                                child: Icon(Icons.visibility,
                                                    color: mostadamTintColor()))))
                                  ]),
                              boxShadowList: [buildMostadamBoxShadow()]);
                        }),
                    Container(height: 0.5, color: Colors.grey),
                    Container(
                        width: widget.size.width * 0.85,
                        child: CustomAppText(
                            placeHolder: "بيانات أخرى",
                            fontColor: Colors.black,
                            textAlign: TextAlign.right)),
                    SizedBox(height: 10),
                    Container(
                      width: widget.size.width * 0.85,
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: BlocBuilder<RegisterBloc, RegisterState>(
                          buildWhen: (previous, current) {
                        if ((current is BankDataDownloadedState) ||
                            (current is BankDataChangeState)) {
                          return true;
                        }
                        return false;
                      }, builder: (context, state) {
                        return DropdownButton(
                          value: (state is BankDataChangeState)
                              ? state.bankData
                              : (state is BankDataDownloadedState)
                                  ? state.bankDataModel.value.first
                                  : null,
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 20,
                          underline: Container(
                            height: 0,
                          ),
                          elevation: 0,
                          style: TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 17,
                              color: Colors.black),
                          onChanged: (value) {
                            context
                                .read<RegisterBloc>()
                                .add(BankDataChanged(bankData: value));
                          },
                          items: widget.registerBloc.registerData.bankDataList !=
                                  null
                              ? widget.registerBloc.registerData.bankDataList.value
                                  .map<DropdownMenuItem<BankData>>(
                                      (BankData value) {
                                  return DropdownMenuItem<BankData>(
                                    value: value,
                                    child: Text(value.name),
                                  );
                                }).toList()
                              : null,
                        );
                      }),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [buildMostadamBoxShadow()],
                          borderRadius:
                              BorderRadius.circular(widget.size.width / 2)),
                    ),
                    BlocBuilder<RegisterBloc, RegisterState>(
                        builder: (context, state) {
                          return RegistrationTextFieldContainer(
                              showError: widget.registerBloc.registerData.ibanNumber != null
                                  ? widget.registerBloc.registerData.ibanNumber.invalid
                                  : false,
                              errorMsg: widget.registerBloc.registerData.ibanNumber != null
                                  ? widget.registerBloc.registerData.ibanNumber.error
                                  : null,
                              child: TextField(
                                obscureText: false,
                                onChanged: (iban) => context
                                    .read<RegisterBloc>()
                                    .add(IbanNumberChanged(ibanNumber: iban)),
                                decoration: InputDecoration(
                                    isCollapsed: true,
                                    hintText: getLocalizedText(context, "IBAN_PLACEHOLDER") ??
                                        "رقم الIBAN",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "Cairo",
                                      fontSize: 15,
                                    ),
                                    contentPadding: EdgeInsets.only(left: 5, right: 5),
                                    border: InputBorder.none),
                              ),
                              boxShadowList: [buildMostadamBoxShadow()]);
                        }),
                    IconWithDescriptionLayout(
                      size: widget.size,
                      showDesc: false,
                      icon: Icon(Icons.info, color: mostadamTintColor()),
                      iconLocalizedTitle: "IBAN_MSG",
                      iconTitleDefaultValue:
                          "رقم الآيبان يتكون من ٢٤ حرف ويبدأ بالحرفين SA مثال SA0000000000000000000000",
                      backgroundColor: Colors.white,
                      iconTitleFontSize: 14,
                      iconTitleFontWeight: FontWeight.normal,
                      showShadow: false,
                    ),
                    Container(
                      child: Row(
                        children: [
                          BlocBuilder<RegisterBloc, RegisterState>(
                              // stream: widget.registerBloc.isSwitched.stream,
                              builder: (context, snapshot) {
                            return Switch(
                              value: widget.registerBloc.registerData.isSwitched !=
                                      null
                                  ? widget.registerBloc.registerData.isSwitched
                                  : isSwitched,
                              onChanged: (bool) {
                                isSwitched = bool;
                                context
                                    .read<RegisterBloc>()
                                    .add(AcceptTermsChanged(isSwitched: bool));
                              },
                              activeTrackColor: mostadamTintColor(),
                              activeColor: Colors.white,
                            );
                          }),
                          TextButton(
                            onPressed: () {

                              context
                                  .read<RegisterBloc>()
                                  .add(AcceptTermsChanged(isSwitched: !isSwitched));
                              isSwitched = !isSwitched;
                            },
                            child: Row(
                              children: [
                                CustomAppText(
                                    placeHolder: "الموافقة على",
                                    fontColor: Colors.black,
                                    showUnderLine: false),
                                CustomAppText(
                                    placeHolder: " الشروط و الأحكام",
                                    fontColor: Colors.blueAccent,
                                    showUnderLine: true)
                              ],
                            ),
                            style: ButtonStyle(overlayColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.grey[100];
                              }
                              return null;
                            })),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: widget.size.width * 0.85,
                            height: 40,
                            child: BlocBuilder<RegisterBloc, RegisterState>(
                              builder: (context, snapshot) {
                                return ElevatedButton(
                                    child: Text(
                                      getLocalizedText(context, "continue") ?? "متابعة",
                                      style: TextStyle(
                                          fontFamily: "Cairo",
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                          color: Colors.white),
                                    ),
                                    onPressed: widget.registerBloc.registerData.isSwitched != null ? widget.registerBloc.registerData.isSwitched == true ? () {
                                      //Register Request
                                      context.read<RegisterBloc>().add(RegisterationDataChanged());
                                    }: null : null,
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
                                          return mostadamTintColor().withOpacity(0.7);
                                        return mostadamTintColor(); // Use the component's default.
                                      }),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                        // side: BorderSide(color: Colors.red)
                                      )),
                                    ));
                              }
                            )),
                        SizedBox(height: 10),
                        Container(
                          width: widget.size.width * 0.85,
                          height: 40,
                          child: ElevatedButton(
                              child: Text(
                                getLocalizedText(context, "back") ?? "العودة",
                                style: TextStyle(
                                    fontFamily: "Cairo",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: mostadamTintColor()),
                              ),
                              onPressed: () {
                                RegisterViewState.tabController.animateTo(1);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(20),
                                    side: BorderSide(
                                        width: 1, color: mostadamTintColor())),
                                elevation: 0,
                              )),
                        )
                      ],
                    ),
                    SizedBox(height: 15)
                  ],
                ),
              ))
          ),
        ),
      BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
        return Visibility(
            visible: (state is LoadingState)
                ? ((state as LoadingState).registerStatus ==
                        RegisterStatus.loading
                    ? true
                    : false)
                : false,
            child: Center(child: Loading(loadingMessage: "")));
      })
    ]);
  }
}
