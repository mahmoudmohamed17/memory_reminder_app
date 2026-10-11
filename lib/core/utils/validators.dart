import 'app_strings.dart';

class Validators {
  Validators._();

  static String? requiredField(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.requiredField;
    }
    return null;
  }
}
