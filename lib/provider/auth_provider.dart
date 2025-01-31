import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shop/shared/shared_prefs_helper.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  String? _username; // Store the username locally
  String? _email; // Store the email locally
  bool _isAdmin = false; // Store the user's role

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get username => _username;
  String? get email => _email;
  bool get isAdmin => _isAdmin;

  // Base URL for the API
  final String _baseUrl = 'http://192.168.201.7/api';

  // Register a new user
  Future<bool> register(String username, String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register.php'),
        body: {
          'name': username,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          // Save user data locally
          _username = username;
          _email = email;
          _errorMessage = null;

          // Optionally, save to SharedPreferences
          await SharedPrefsHelper.setLoggedIn(true);
          await SharedPrefsHelper.setUsername(username);
          await SharedPrefsHelper.setEmail(email);

          return true; // Registration successful
        } else {
          _errorMessage = data['message'] ?? 'Registration failed!';
          return false; // Registration failed
        }
      } else {
        _errorMessage = 'Server error: ${response.statusCode}';
        return false; // Registration failed
      }
    } catch (error) {
      _errorMessage = "Registration failed: ${error.toString()}";
      return false; // Registration failed
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Login an existing user
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login.php'),
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          // // Save user data locally
          // _username =
          //     data['user']['name']; // Save the username from the API response
          // _email = email;
          // _isAdmin = data['user']['is_admin'] == 1; // Save the user's role
          // _errorMessage = null;

          // Save to SharedPreferences
          await SharedPrefsHelper.setLoggedIn(true);
          // await SharedPrefsHelper.setUsername(_username!);
          // await SharedPrefsHelper.setEmail(email);
          // await SharedPrefsHelper.setIsAdmin(_isAdmin);

          return true; // Login successful
        } else {
          _errorMessage = data['message'] ?? 'Login failed!';
          return false; // Login failed
        }
      } else {
        _errorMessage = 'Server error: ${response.statusCode}';
        return false; // Login failed
      }
    } catch (error) {
      _errorMessage = "Login failed: ${error.toString()}";
      return false; // Login failed
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update user profile
  Future<void> updateProfile(String newUsername, String newPassword) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/update_profile.php'),
        body: {
          'email': _email,
          'username': newUsername,
          'password': newPassword,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          // Update local username
          _username = newUsername;

          // Save to SharedPreferences
          await SharedPrefsHelper.setUsername(newUsername);

          _errorMessage = null;
        } else {
          _errorMessage = data['message'] ?? 'Profile update failed!';
        }
      } else {
        _errorMessage = 'Server error: ${response.statusCode}';
      }
    } catch (error) {
      _errorMessage = "Profile update failed: ${error.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Logout the user
  void logout() {
    _username = null;
    _email = null;
    _isAdmin = false;
    _errorMessage = null;

    // Clear saved data from SharedPreferences
    SharedPrefsHelper.clearPreferences();

    notifyListeners();
  }
}
