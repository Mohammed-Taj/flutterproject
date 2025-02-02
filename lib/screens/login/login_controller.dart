import 'package:shop/screens/login/widgets/validators.dart';

class LoginController {
  static String? validateEmail(String? value) {
    return Validators.emailValidator(value);
  }

  static String? validatePassword(String? value) {
    return Validators.passwordValidator(value);
  }
}
