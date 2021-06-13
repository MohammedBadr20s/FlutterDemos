

import 'dart:async';

import 'package:image_picker/image_picker.dart';
import 'package:mostadam_flutter_app/src/modules/Authentication/model/BankDataModel.dart';
import 'package:validators/validators.dart';

class ValidationMixin {
  final validatorUserName = new StreamTransformer<String, String>.fromHandlers(handleData: (user, sink) {
    if (user.length < 5) {
      sink.addError('يجب كتابة اسم المستخدم');
    } else {
      sink.add(user);
    }
  });

  final validatorIdentityNum = new StreamTransformer<String, String>.fromHandlers(handleData: (identity, sink) {

    if (identity == null) {
      sink.addError("هذا الحقل مطلوب");
    } else if (identity.length < 10) {
      sink.addError("رقم الهوية يجب ان يكون على الأقل 10 أحرف");
    } else {
      sink.add(identity);
    }
  });

  final validatorMembership = new StreamTransformer<String, String>.fromHandlers(handleData: (membership, sink) {

    if (membership == null) {
      sink.addError("هذا الحقل مطلوب");
    } else if (membership.length < 5) {
      sink.addError("رقم العضوية يجب ان يكون اكبر من او يساوي 5 احرف");
    } else {
      sink.add(membership);
    }
  });

  final validatorPassword = new StreamTransformer<String, String>.fromHandlers(handleData: (password, sink) {
    if (password.length < 8 || password.length > 25) {
      sink.addError("كلمة المرور لا تقل عن ٨ حروف ولا تزيد عن ٢٥ حرف ولا يقبل النظام كلمات المرور الضعيفة");
    } else if (isAscii(password) == false) {
      sink.addError("كلمة المرور يجب ان تتكون من حروف وأرقام");
    } else {
      sink.add(password);
    }
  });
  static bool validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return false;
    }
    else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }
  final validatorPhone = new StreamTransformer<String, String>.fromHandlers(handleData: (phone, sink) {

    if (validateMobile(phone) == false) {
      sink.addError("رقم الجوال يجب ان يكون رقم سعودي");
    } else {
      sink.add(phone);
    }
  });

  final validatorEmail = new StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {

    if (!isEmail(email)) {
      sink.addError('البريد الإلكتروني يجب ان تكون مكونه من اكثر من 5 احرف');
    } else {
      sink.add(email);
    }
  });
  final validatorCertificate = new StreamTransformer<String, String>.fromHandlers(handleData: (certificate, sink) {
    if (certificate.isEmpty) {
      sink.addError('رقم الشهادة مطلوب');
    } else if (isNumeric(certificate) == false ) {
      sink.addError('رقم الشهادة يجب ان يكون');
    } else {
      sink.add(certificate);
    }
  });

  final validatorIBAN = new StreamTransformer<String, String>.fromHandlers(handleData: (iban, sink) {
    if (iban.isEmpty) {
      sink.addError('رقم ال Iban مطلوب');
    } else if (iban.length > 2 && iban[0].toLowerCase() != "s" && iban[1].toLowerCase() != "a") {
      sink.addError('رقم الIban يجب ان يبدأ ب SA');
    } else if (iban.length != 24) {
      sink.addError("رقم الآيبان يتكون من ٢٤ حرف ويبدأ بالحرفين SA مثال SA0000000000000000000000");
    } else {
      sink.add(iban);
    }
  });
  final validatorBankData = new StreamTransformer<BankData, BankData>.fromHandlers(handleData: (data, sink) {
    if (data.name == 'أسم البنك') {
      sink.addError('يرجى تحديد أسم البنك');
    } else {
      sink.add(data);
    }
  });
  final validatorSwitch = new StreamTransformer<bool, bool>.fromHandlers(handleData: (data, sink) {
    if (data == false) {
      sink.addError('يرجى الموافقة اولاً');
    } else {
      sink.add(data);
    }
  });
  final validatorFile = new StreamTransformer<PickedFile, PickedFile>.fromHandlers(handleData: (certificate, sink) {
    if (isNull(certificate.path)) {
      sink.addError('صورةالشهادة مطلوبة');
    } else {
      sink.add(certificate);
    }
  });

}