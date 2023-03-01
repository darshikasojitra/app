import 'package:demo_splash_screen/user_preferences/global_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String selectedLocaleLanguageCodePref = "selectLocaleLanguageCodePref";

class UserPreferences{
static Future<void> setLocaleLanguageCode(
      {required String languageCode}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(selectedLocaleLanguageCodePref, languageCode);
    GlobalVariables.languageCode = languageCode;
  }
     static Future<String> getLocaleLanguageCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(selectedLocaleLanguageCodePref) ??
        LanguageCode.languageCodeEnglish;
  }
}