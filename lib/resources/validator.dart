import 'package:demo_splash_screen/resources/resources.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Validator {
  static MultiValidator emailValidator = MultiValidator([
    RequiredValidator(errorText: StringManager.enteremail),
    PatternValidator(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
        errorText: StringManager.validemail)
  ]);

  static MultiValidator cardnamevalidator =
      MultiValidator([RequiredValidator(errorText: 'enter card name')]);

  static MultiValidator cardnovalidator = MultiValidator([
    RequiredValidator(errorText: 'enter card number'),
    //MaxLengthValidator(17, errorText: 'enter 16 digit card number '),
    PatternValidator(r'[0-9]', errorText: 'enter only numbers')
  ]);

  static MultiValidator expdatevalidator = MultiValidator([
    RequiredValidator(errorText: 'enter expiry date'),
    PatternValidator(r'^\d{2}\/\d{2}$', errorText: 'enter date mm/yy')
  ]);

  static MultiValidator cvvnovalidator = MultiValidator([
    RequiredValidator(errorText: 'enter CVV number'),
    PatternValidator(r'[0-9]', errorText: 'enter only numbers'),
    MaxLengthValidator(3, errorText: 'enter 3 digit CVV number '),
  ]);

  static MultiValidator passValidator = MultiValidator([
    RequiredValidator(errorText: StringManager.enterpassword),
    MinLengthValidator(6, errorText: StringManager.validpassword),
    // PatternValidator(
    //     "r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}",
    //     errorText: "please enter vaild password")
  ]);

  static String? confirmpassworrd(String val, String password) {
    if (val.isEmpty) {
      return StringManager.entercpassword;
    }
    if (val != password) {
      return StringManager.validcpassword;
    }
    return null;
  }

  static final nameValidator = MultiValidator([
    RequiredValidator(errorText: StringManager.entername),
  ]);

  static final newlistValidator = MultiValidator([
    RequiredValidator(errorText: "enter list name"),
  ]);
}
