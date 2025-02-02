class RegisterController {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email';
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
    if (!emailRegex.hasMatch(value))
      return 'Please enter a valid email address';
    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your username';
    if (value.length < 3) return 'Username must be at least 3 characters';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your password';
    if (value.length < 6) return 'Password must be at least 6 characters';
    if (!RegExp(r'(?=.*?[A-Z])').hasMatch(value))
      return 'Password must contain at least one uppercase letter';
    if (!RegExp(r'(?=.*?[0-9])').hasMatch(value))
      return 'Password must contain at least one number';
    if (!RegExp(r'(?=.*?[!@#$%^&*])').hasMatch(value))
      return 'Password must contain at least one special character';
    return null;
  }
}
