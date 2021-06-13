import 'package:analyzer/file_system/file_system.dart';
import 'package:formz/formz.dart';
import 'package:validators/validators.dart';

class MembershipNum extends FormzInput<String, String> {
  const MembershipNum.pure() : super.pure('');

  const MembershipNum.dirty([String value = '']) : super.dirty(value);

  @override
  String validator(String value) {
    return value?.isNotEmpty == true
        ? (value.length < 5
            ? "رقم العضوية يجب ان يكون اكبر من او يساوي 5 احرف"
            : "")
        : "هذا الحقل مطلوب";
  }
}

class IdentityNum extends FormzInput<String, String> {
  const IdentityNum.pure() : super.pure('');

  const IdentityNum.dirty([String value = '']) : super.dirty(value);

  @override
  String validator(String value) {
    return value?.isNotEmpty == true
        ? (value.length < 10 ? "رقم الهوية يجب ان يكون على الأقل 10 أحرف" : '')
        : "هذا الحقل مطلوب";
  }
}

class PhoneNumber extends FormzInput<String, String> {
  const PhoneNumber.pure() : super.pure('');

  const PhoneNumber.dirty([String value = '']) : super.dirty(value);

  bool validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    }
    return true;
  }

  @override
  String validator(String value) {
    return value?.isNotEmpty == true
        ? (validateMobile(value) == false
            ? "رقم الجوال يجب ان يكون رقم سعودي"
            : null)
        : "هذا الحقل مطلوب";
  }
}

class ValidateCertificate extends FormzInput<String, String> {
  const ValidateCertificate.pure() : super.pure('');

  const ValidateCertificate.dirty([String value = '']) : super.dirty(value);

  @override
  String validator(String value) {
    return value?.isNotEmpty == true
        ? (isNumeric(value) == false ? 'رقم الشهادة يجب ان يكون' : '')
        : 'رقم الشهادة مطلوب';
  }
}

class IbanNumber extends FormzInput<String, String> {
  const IbanNumber.pure() : super.pure('');

  const IbanNumber.dirty([String value = '']) : super.dirty(value);

  @override
  String validator(String value) {
    return value?.isNotEmpty == true
        ? ((value.length > 2 &&
                value[0].toLowerCase() != "s" &&
                value[1].toLowerCase() != "a")
            ? 'رقم الIban يجب ان يبدأ ب SA'
            : (value.length != 24)
                ? "رقم الآيبان يتكون من ٢٤ حرف ويبدأ بالحرفين SA مثال SA0000000000000000000000"
                : '')
        : 'رقم ال Iban مطلوب';
  }
}

class ValidateCertificateFile extends FormzInput<String, String> {
  const ValidateCertificateFile.pure() : super.pure('');

  const ValidateCertificateFile.dirty([String value = '']) : super.dirty(value);

  @override
  String validator(String value) {
    return value?.isNotEmpty == true ? '' : 'رقم الشهادة مطلوب';
  }
}
