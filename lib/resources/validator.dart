import 'package:demo_splash_screen/resources/resources.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Validator {
  static MultiValidator emailValidator = MultiValidator([
    RequiredValidator(errorText: StringManager.enteremail),
    PatternValidator(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
        errorText: StringManager.validemail)
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
}
