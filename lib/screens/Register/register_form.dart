import 'package:flutter/material.dart';
import 'package:shop/screens/Register/register_controller.dart';
import 'package:shop/screens/Register/widgets/custom_button.dart';
import 'package:shop/screens/Register/widgets/custom_input_field.dart';

class RegisterForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isPasswordVisible;
  final bool isLoading;
  final VoidCallback onPasswordVisibilityToggle;
  final VoidCallback onRegisterPressed;

  const RegisterForm({
    required this.formKey,
    required this.usernameController,
    required this.emailController,
    required this.passwordController,
    required this.isPasswordVisible,
    required this.isLoading,
    required this.onPasswordVisibilityToggle,
    required this.onRegisterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          CustomInputField(
            controller: usernameController,
            label: 'Username',
            icon: Icons.person,
            validator: RegisterController.validateUsername,
          ),
          const SizedBox(height: 20),
          CustomInputField(
            controller: emailController,
            label: 'Email',
            icon: Icons.email,
            validator: RegisterController.validateEmail,
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
            validator: RegisterController.validatePassword,
          ),
          const SizedBox(height: 24),
          CustomButton(
            onPressed: onRegisterPressed,
            isLoading: isLoading,
            text: 'Register',
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/login'),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'Log in',
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
