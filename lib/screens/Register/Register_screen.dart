import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/auth_provider.dart';
import 'package:shop/screens/Register/register_animations.dart';
import 'package:shop/screens/Register/register_form.dart';
import 'package:shop/screens/Verification.dart';
import 'package:shop/shared/shared_prefs_helper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  Future<void> _handleRegistration(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final success = await authProvider.register(username, email, password);

    setState(() => _isLoading = false);

    if (success) {
      await SharedPrefsHelper.setLoggedIn(true);
      await SharedPrefsHelper.setUsername(username);
      await SharedPrefsHelper.setEmail(email);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Verification(email: email),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.errorMessage ?? 'Registration failed!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 80),
              RegisterAnimations.buildAppLogo(),
              const SizedBox(height: 24),
              RegisterAnimations.buildWelcomeText(),
              const SizedBox(height: 40),
              RegisterForm(
                formKey: _formKey,
                usernameController: _usernameController,
                emailController: _emailController,
                passwordController: _passwordController,
                isPasswordVisible: _isPasswordVisible,
                isLoading: _isLoading,
                onPasswordVisibilityToggle: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                onRegisterPressed: () => _handleRegistration(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
