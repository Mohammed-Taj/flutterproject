import 'package:flutter/material.dart';
import 'package:shop/screens/login/login_controller.dart';
import 'package:shop/screens/login/widgets/custom_button.dart';
import 'package:shop/screens/login/widgets/custom_input_field.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isPasswordVisible;
  final bool isLoading;
  final VoidCallback onPasswordVisibilityToggle;
  final VoidCallback onLoginPressed;

  const LoginForm({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.isPasswordVisible,
    required this.isLoading,
    required this.onPasswordVisibilityToggle,
    required this.onLoginPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          CustomInputField(
            controller: emailController,
            label: 'Email',
            icon: Icons.email,
            validator: LoginController.validateEmail,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 20),
          CustomInputField(
            controller: passwordController,
            label: 'Password',
            icon: Icons.lock,
            obscureText: !isPasswordVisible,
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: onPasswordVisibilityToggle,
            ),
            validator: LoginController.validatePassword,
          ),
          const SizedBox(height: 24),
          CustomButton(
            onPressed: onLoginPressed,
            isLoading: isLoading,
            text: 'Log In',
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/register'),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Don\'t have an account? ',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'Register',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
