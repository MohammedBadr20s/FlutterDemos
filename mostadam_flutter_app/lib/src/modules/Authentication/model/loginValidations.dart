import 'package:formz/formz.dart';
import 'package:validators/validators.dart';

enum PasswordValidationError { empty }

class Password extends FormzInput<String, String> {
  const Password.pure() : super.pure('');

  const Password.dirty([String value = '']) : super.dirty(value);

  @override
   String validator(String value) {
    if (value.isNotEmpty == true) {
      if (isAscii(value) == true) {
        if (value.length < 8 || value.length > 25 == true) {
          return "كلمة المرور لا تقل عن ٨ حروف ولا تزيد عن ٢٥ حرف ولا يقبل النظام كلمات المرور الضعيفة";
        } else {
          return null;
        }
      } else {
        return "كلمة المرور يجب ان تتكون من حروف وأرقام";
      }
    } else {
      return 'يجب كتابة كلمة المرور';
    }
  }
}

// enum UsernameValidationError { empty }

class Username extends FormzInput<String, String> {
  const Username.pure() : super.pure('');

  const Username.dirty([String value = '']) : super.dirty(value);

  @override
  String validator(String value) {
    return value?.isNotEmpty == true
        ? null
        : 'يجب كتابة اسم المستخدم';
  }
}

enum EmailValidationError { empty, invalid }

class Email extends FormzInput<String, String> {
  const Email.pure() : super.pure('');

  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  String validator(String value) {
    return value?.isNotEmpty == true
        ? isEmail(value) == true
            ? null
            : 'البريد الإلكتروني يجب ان يكون مكونه من اكثر من 5 احرف'
        : 'يجب كتابة البريد الإلكتروني';
  }
}
