import 'package:flutter/material.dart';
import 'package:shop/constants.dart';

class RegisterAnimations {
  static Widget buildAppLogo() {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        child: Icon(
          Icons.shopping_cart,
          size: 100,
          color: kprimaryColor,
        ),
      ),
    );
  }

  static Widget buildWelcomeText() {
    return Column(
      children: [
        AnimatedOpacity(
          opacity: 1,
          duration: const Duration(milliseconds: 500),
          child: Text(
            'Create an Account',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8),
        AnimatedOpacity(
          opacity: 1,
          duration: const Duration(milliseconds: 700),
          child: Text(
            'Sign up to get started',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
