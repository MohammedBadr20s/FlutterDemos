import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mostadam_flutter_app/src/components/AppLocalizations.dart';
import 'package:mostadam_flutter_app/src/components/Constants.dart';
import 'package:mostadam_flutter_app/src/components/GenericViews.dart';
import 'package:mostadam_flutter_app/src/components/StateViews.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/bloc/register_bloc.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/model/engineerDataModel.dart';
import 'RegisterView.dart';
import 'package:formz/formz.dart';

class PrimaryDataContainer extends StatelessWidget {
  final RegisterBloc registerBloc;

  PrimaryDataContainer({Key key, @required this.size, this.registerBloc})
      : super(key: key);

  final Size size;
  final _form = GlobalKey<FormState>();

  //saving form after validation
  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
        ShadowedContainer(
          size: size,
          child: Form(
            key: _form,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
                child: Column(
              children: [
                SizedBox(height: 10),
                BlocBuilder<RegisterBloc, RegisterState>(
                    buildWhen: (previous, current) {
                  if (previous is IdentityNumChanged &&
                      current is IdentityNumChanged &&
                      (previous as IdentityNumChanged).identityNum != (current as IdentityNumChanged).identityNum) {
                    return true;
                  }
                  return false;
                }, builder: (context, state) {

                  return MostadamRegistrationTextField(
                    localizedKey: "identity_number",
                    defaultValue: "رقم الهوية",
                    //"2306821436"
                    initialValue:
                        (state is IdentityNumChanged) ? (state as IdentityNumChanged).identityNum : '2306821436',
                    size: size,
                    showLabel: true,
                    showShadow: true,
                    // errorMsg: state.identityNumber.error,
                    keyboardType: TextInputType.number,
                    validator: (text) {
                      if (text == null) {
                        return "هذا الحقل مطلوب";
                      } else if (text.length < 10) {
                        return "رقم الهوية يجب ان يكون على الأقل 10 أحرف";
                      }
                      return null;
                    },
                    onChanged: (identity) => (context)
                        .read<RegisterBloc>()
                        .add(IdentityNumChanged(identityNum: identity)),
                  );
                }),
                SizedBox(height: 10),
                BlocBuilder<RegisterBloc, RegisterState>(
                    buildWhen: (previous, current) {
                  if (previous is MembershipNumChanged &&
                      current is MembershipNumChanged &&
                      (previous as MembershipNumChanged).membershipNum != (current as MembershipNumChanged).membershipNum) {
                    return true;
                  }
                  return false;
                }, builder: (context, state) {
                  return MostadamRegistrationTextField(
                      localizedKey: "membership_number",
                      defaultValue: "رقم عضوية هيئة المهندسين السعوديين",
                      //"64826"
                      initialValue: (state is MembershipNumChanged)
                          ? (state as MembershipNumChanged).membershipNum
                          : '64826',
                      size: size,
                      showLabel: true,
                      showShadow: true,
                      // errorMsg: state.membershipNumber.error,
                      keyboardType: TextInputType.number,
                      validator: (text) {
                        if (text == null) {
                          return "هذا الحقل مطلوب";
                        } else if (text.length < 5) {
                          return "رقم العضوية يجب ان يكون اكبر من او يساوي 5 احرف";
                        }
                        return null;
                      },
                      onChanged: (membershipNum) => (context)
                          .read<RegisterBloc>()
                          .add(MembershipNumChanged(
                              membershipNum: membershipNum)));
                }),
                SizedBox(height: 5),
                BlocBuilder<RegisterBloc, RegisterState>(
                    buildWhen: (previous, current) {
                  if (previous is MembershipNumChanged &&
                      current is MembershipNumChanged &&
                      (previous as MembershipNumChanged).membershipNum != (current as MembershipNumChanged).membershipNum) {
                    return true;
                  }
                  return false;
                }, builder: (context, state) {
                  return Container(
                    width: size.width * 0.5,
                    child: ElevatedButton(
                        child: Text(
                          getLocalizedText(context, "validate_title") ?? "تحقق",
                          style: TextStyle(
                              fontFamily: "Cairo",
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              color: mostadamTintColor()),
                        ),
                        onPressed: () {
                          _saveForm();
                          (context)
                              .read<RegisterBloc>()
                              .add(EngineerDataRequest());
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed))
                                return Colors.white;
                              else if (states.contains(MaterialState.disabled))
                                return Colors.white.withOpacity(0.5);
                              return Colors.white; // Use the component's default.
                            }),
                            shape: MaterialStateProperty.resolveWith<
                                    RoundedRectangleBorder>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: BorderSide(color: mostadamTintColor()));
                              } else if (states
                                  .contains(MaterialState.disabled)) {
                                return RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: BorderSide(
                                        color: mostadamTintColor()
                                            .withOpacity(0.5)));
                              }
                              return RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(color: mostadamTintColor()));
                            }),
                            elevation: MaterialStateProperty.all(0))),
                  );
                }),
                SizedBox(height: 5),
                EngineeringDataView(size: size, bloc: registerBloc)
              ],
            )),
          ),
        ),
        BlocBuilder<RegisterBloc, RegisterState>(
            buildWhen: (previous, current) =>
                previous.registerStatus != current.registerStatus,
            builder: (context, state) {
              return Visibility(
                  visible: (state is LoadingState) ? true : false,
                  child: Center(child: Loading(loadingMessage: "")));
            })
      ]);
  }
}

class EngineeringDataView extends StatelessWidget {
  final Size size;
  final RegisterBloc bloc;

  EngineeringDataView({this.size, this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
            buildWhen: (previous, current) =>
                previous.registerStatus != current.registerStatus,
            builder: (context, state) {
              String formattedMembershipExpirationDate = '';
              EngineerData engineeringData;
              if (state is EngineeringDataState) {
                engineeringData = (state as EngineeringDataState).engineerData;
                final DateTime now = DateFormat('dd/MM/yyyy HH:mm:ss')
                    .parse(engineeringData.value.membershipEndDate);
                final DateFormat formatter = DateFormat("dd/MM/yyyy");
                formattedMembershipExpirationDate = formatter.format(now);
              }
              return Column(
                children: [
                  MostadamRegistrationTextField(
                      size: size,
                      initialValue: engineeringData != null
                          ? engineeringData.value.fullName
                          : '',
                      localizedKey: "full_name",
                      defaultValue: "الأسم كامل",
                      showLabel: engineeringData != null ? true : false,
                      enabled: false,
                      showBorder: true,
                      keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 5),
                  MostadamRegistrationTextField(
                      size: size,
                      initialValue: engineeringData != null
                          ? engineeringData.value.idNumber
                          : '',
                      localizedKey: "civil_registry",
                      defaultValue: "رقم السجل المدني",
                      showLabel: engineeringData != null ? true : false,
                      enabled: false,
                      showBorder: true,
                      keyboardType: TextInputType.number),
                  SizedBox(height: 5),
                  MostadamRegistrationTextField(
                      size: size,
                      initialValue: engineeringData != null
                          ? engineeringData.value.specialization
                          : '',
                      localizedKey: "inspector_speciality",
                      defaultValue: "تخصص الفاحص",
                      showLabel: engineeringData != null ? true : false,
                      enabled: false,
                      showBorder: true,
                      keyboardType: TextInputType.text),
                  SizedBox(height: 5),
                  MostadamRegistrationTextField(
                      size: size,
                      initialValue: engineeringData != null
                          ? engineeringData.value.membershipNo
                          : '',
                      localizedKey: "membership_number_min",
                      defaultValue: "رقم العضوية",
                      showLabel: engineeringData != null ? true : false,
                      enabled: false,
                      showBorder: true,
                      keyboardType: TextInputType.number),
                  SizedBox(height: 5),
                  MostadamRegistrationTextField(
                      size: size,
                      initialValue: engineeringData != null
                          ? formattedMembershipExpirationDate
                          : "",
                      localizedKey: "membership_expiration",
                      defaultValue: "تاريخ إنتهاء العضوية",
                      showLabel: engineeringData != null ? true : false,
                      enabled: false,
                      showBorder: true),
                  SizedBox(height: 5),
                  Container(
                    width: size.width * 0.85,
                    height: 40,
                    child: ElevatedButton(
                        child: Text(
                          getLocalizedText(context, "continue") ?? "متابعة",
                          style: TextStyle(
                              fontFamily: "Cairo",
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.white),
                        ),
                        onPressed: (state is EngineeringDataState)
                            ? () {
                                RegisterViewState.tabController.animateTo(1);
                              }
                            : null,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed))
                              return Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.8);
                            else if (states.contains(MaterialState.disabled))
                              return mostadamTintColor().withOpacity(0.7);
                            return mostadamTintColor(); // Use the component's default.
                          }),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            // side: BorderSide(color: Colors.red)
                          )),
                        )),
                  ),
                  SizedBox(height: 15)
                ],
              );
            });
  }
}
