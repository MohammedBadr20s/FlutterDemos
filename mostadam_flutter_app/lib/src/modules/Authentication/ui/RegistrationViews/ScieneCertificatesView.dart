import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mostadam_flutter_app/src/components/AppLocalizations.dart';
import 'package:mostadam_flutter_app/src/components/Constants.dart';
import 'package:mostadam_flutter_app/src/components/GenericViews.dart';
import 'package:mostadam_flutter_app/src/components/utils.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/bloc/register_bloc.dart';
import 'package:validators/validators.dart';

import 'RegisterView.dart';

class ScienceCertificatesView extends StatelessWidget {
  final Size size;
  final RegisterBloc registerBloc;

  ScienceCertificatesView({this.size, this.registerBloc});

  final _form = GlobalKey<FormState>();
  final picker = ImagePicker();

  //saving form after validation
  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
  }

  getImageFromCamera(
      {BuildContext context,
      ImagePicker picker,
      @required FileDataType dataType}) async {
    var image = await picker.getImage(source: ImageSource.camera);
    if (image != null) {
      // print("Image: $image");
      switch (dataType) {
        case FileDataType.QUALITY_CERTIFICATE:
          (context).read<RegisterBloc>().add(
              BuildingQualityCertFileChanged(buildingQualityCertFile: image));
          break;
        case FileDataType.READY_BUILDING_CERTIFICATE:
          (context).read<RegisterBloc>().add(
              ReadyBuildingQualityCertFileChanged(
                  readyBuildingQualityCertFile: image));
          break;
      }
    }
  }

  getImageFromLibrary(
      {BuildContext context,
      ImagePicker picker,
      @required FileDataType dataType}) async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image != null) {
      // print("Image: $image");
      switch (dataType) {
        case FileDataType.QUALITY_CERTIFICATE:
          (context).read<RegisterBloc>().add(
              BuildingQualityCertFileChanged(buildingQualityCertFile: image));
          break;
        case FileDataType.READY_BUILDING_CERTIFICATE:
          (context).read<RegisterBloc>().add(
              ReadyBuildingQualityCertFileChanged(
                  readyBuildingQualityCertFile: image));
          break;
      }
    }
  }

  showPicker(context, {@required FileDataType dataType}) {
    // Future<PickedFile> image;
    List<ListTile> items = [
      new ListTile(
          leading: new Icon(Icons.photo_library, color: Colors.white),
          horizontalTitleGap: 0,
          title: new CustomAppText(
              placeHolder: 'Photo Library',
              textAlign: getCurrentLocale(context).languageCode == 'ar'
                  ? TextAlign.right
                  : TextAlign.left),
          onTap: () {
            getImageFromLibrary(
                context: context, picker: picker, dataType: dataType);
            Navigator.pop(context);
          }),
      new ListTile(
        leading: new Icon(Icons.photo_camera, color: Colors.white),
        horizontalTitleGap: 0,
        title: new CustomAppText(
            placeHolder: 'Camera',
            textAlign: getCurrentLocale(context).languageCode == 'ar'
                ? TextAlign.right
                : TextAlign.left),
        onTap: () {
          getImageFromCamera(
              context: context, picker: picker, dataType: dataType);
          Navigator.pop(context);
        },
      ),
    ];
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            // padding: EdgeInsets.all(10),
            height: 140,
            decoration: BoxDecoration(
                color: mostadamTintColor(),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: new ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) {
                return items[index];
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.white,
                  height: 1,
                  indent: 10,
                  endIndent: 10,
                );
              },
            ),
          );
        });
    // return image;
  }

  @override
  Widget build(BuildContext context) {
    return ShadowedContainer(
      size: size,
      child: Form(
        key: _form,
        autovalidateMode: AutovalidateMode.always,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              IconWithDescriptionLayout(
                size: size,
                localizedKey: "DEAR_ENGINEER_MSG",
                defaultValue:
                    "في حال كنت مؤهل للانضمام كفاحص لأحدى الخدمتين فقط يمكنكم متابعة طلب الانضمام بإرفاق شهادة الإجتياز للدورة التأهيلية الخاصة بالخدمة في الخانة المطلوبة بدون الحاجة الي ارفاق أي مستند في خانة الدورة الخاصة بالخدمة الاخرى",
                icon: Icon(Icons.warning_amber_rounded,
                    color: mostadamTextdarkBlueColor()),
                iconTitleDefaultValue: "عزيزي الفاحص",
                backgroundColor: mostadamViewBackgroundColor(),
              ),
              SizedBox(height: 15),
              MostadamRegistrationTextField(
                  localizedKey: "BUILDING_QUALITY_CERTIFICATE",
                  defaultValue: "رقم شهادة خدمة جودة البناء",
                  size: size,
                  showLabel: true,
                  showShadow: true,
                  keyboardType: TextInputType.number,
                  validator: (text) {
                    if (text.isEmpty) {
                      return 'رقم الشهادة مطلوب';
                    } else if (isNumeric(text) == false) {
                      return 'رقم الشهادة يجب ان يكون رقم';
                    }
                    return null;
                  },
                  onChanged: (text) {
                    print(text);
                    context.read<RegisterBloc>().add(
                        BuildingQualityNumChanged(buildingQualityNum: text));
                    // registerBloc.buildingQualityNum.sink.add(text);
                  }),
              SizedBox(height: 10),
              BlocBuilder<RegisterBloc, RegisterState>(
                  buildWhen: (previous, current) => previous != current,
                  builder: (context, snapshot) {
                    return MostadamUploadButton(
                        value: registerBloc
                                    .registerData.buildingQualityCerFileData !=
                                null
                            ? registerBloc
                                .registerData.buildingQualityCerFileData.path
                                .split('/')
                                .last
                                .split('_')
                                .last
                            : "",
                        localizedKey: "QUALITY_CERTIFICATE",
                        defaultValue: "شهادة خدمة الجودة",
                        showError: registerBloc
                                .registerData.buildingQualityCerFileData ==
                            null,
                        errorMsg: 'صورةالشهادة مطلوبة',
                        onPressed: () async {
                          // _showPicker(context);
                          showPicker(context,
                              dataType: FileDataType.QUALITY_CERTIFICATE);
                        });
                  }),
              SizedBox(height: 10),
              MostadamRegistrationTextField(
                  // initialValue: registerBloc.readyBuildingQualityNum.value,
                  localizedKey: "READY_BUILDING_CERTIFICATE_NUMBER",
                  defaultValue: "رقم شهادة المباني الجاهزة",
                  size: size,
                  showLabel: true,
                  showShadow: true,
                  validator: (text) {
                    if (text.isEmpty) {
                      return 'رقم الشهادة مطلوب';
                    } else if (isNumeric(text) == false) {
                      return 'رقم الشهادة يجب ان يكون رقم';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    context.read<RegisterBloc>().add(
                        ReadyBuildingQualityNumChanged(
                            readyBuildingQualityNum: text));
                    // registerBloc.readyBuildingQualityNum.sink.add(text);
                  }),
              SizedBox(height: 10),
              BlocBuilder<RegisterBloc, RegisterState>(
                  buildWhen: (previous, current) => previous != current,
                  builder: (context, snapshot) {
                    return MostadamUploadButton(
                        value: registerBloc.registerData
                                    .readyBuildingQualityCerFileData !=
                                null
                            ? registerBloc.registerData
                                .readyBuildingQualityCerFileData.path
                                .split('/')
                                .last
                                .split('_')
                                .last
                            : "",
                        localizedKey: "READY_BUILDING_CERTIFICATE",
                        defaultValue: "شهادة فحص المباني الجاهزة",
                        showError: registerBloc
                                .registerData.readyBuildingQualityCerFileData ==
                            null,
                        errorMsg: 'صورةالشهادة مطلوبة',
                        onPressed: () {
                          // _showPicker(context);
                          showPicker(context,
                              dataType:
                                  FileDataType.READY_BUILDING_CERTIFICATE);
                        });
                  }),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: size.width * 0.4,
                    height: 40,
                    child: BlocBuilder<RegisterBloc, RegisterState>(
                        buildWhen: (previous, current) => previous != current,
                        builder: (context, snapshot) {
                          bool continueCondition = ((registerBloc
                                          .registerData.buildingQualityNum !=
                                      null &&
                                  registerBloc.registerData.buildingQualityNum
                                          .isEmpty ==
                                      false) &&
                              registerBloc.registerData
                                      .buildingQualityCerFileData !=
                                  null &&
                              (registerBloc.registerData
                                          .readyBuildingQualityNum !=
                                      null &&
                                  registerBloc.registerData
                                          .readyBuildingQualityNum.isEmpty ==
                                      false) &&
                              registerBloc.registerData
                                      .readyBuildingQualityCerFileData !=
                                  null);
                          return ElevatedButton(
                              child: Text(
                                getLocalizedText(context, "continue") ??
                                    "متابعة",
                                style: TextStyle(
                                    fontFamily: "Cairo",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                              onPressed: continueCondition
                                  ? () {
                                      RegisterViewState.tabController
                                          .animateTo(2);
                                    }
                                  : null,
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
                        }),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: size.width * 0.4,
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
                          RegisterViewState.tabController.animateTo(0);
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
