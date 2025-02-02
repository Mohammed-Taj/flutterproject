import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/auth_provider.dart';
import 'package:shop/screens/login/login_form.dart';
import 'package:shop/screens/login/login_animations.dart';
import 'package:shop/shared/shared_prefs_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  Future<void> _handleLogin(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final success = await authProvider.login(email, password);

      if (success) {
        await SharedPrefsHelper.setLoggedIn(true);
        await SharedPrefsHelper.setEmail(email);
        await SharedPrefsHelper.setUsername(authProvider.username ?? '');
        await SharedPrefsHelper.setIsAdmin(authProvider.isAdmin);
        final bool isadmin = await SharedPrefsHelper.isAdmin();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate based on user role
        if (isadmin) {
          Navigator.pushReplacementNamed(context, '/DisplayProductsScreen');
          // await SharedPrefsHelper.setIsAdmin(true);
        } else {
          Navigator.pushReplacementNamed(context, '/nav-bar');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authProvider.errorMessage ?? 'Login failed!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
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
              LoginAnimations.buildAppLogo(),
              const SizedBox(height: 24),
              LoginAnimations.buildWelcomeText(),
              const SizedBox(height: 40),
              LoginForm(
                formKey: _formKey,
                emailController: _emailController,
                passwordController: _passwordController,
                isPasswordVisible: _isPasswordVisible,
                isLoading: _isLoading,
                onPasswordVisibilityToggle: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                onLoginPressed: () => _handleLogin(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
