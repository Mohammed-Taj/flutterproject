import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shop/shared/shared_prefs_helper.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  String? _username; // Store the username locally
  String? _password; // Store the password locally
  String? _email; // Store the email locally
  bool _isAdmin = false; // Store the user's role

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get username => _username;
  String? get password => _password;

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
          _password = password;
          _email = email;
          _errorMessage = null;

          // Optionally, save to SharedPreferences
          await SharedPrefsHelper.setLoggedIn(true);
          await SharedPrefsHelper.setUsername(username);
          await SharedPrefsHelper.setEmail(email);
          await SharedPrefsHelper.setPassword(password);

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
          // Save to SharedPreferences
          _username = data['name'];
          _email = email;
          _password = password;

          await SharedPrefsHelper.setLoggedIn(true);
          await SharedPrefsHelper.setUsername(_username!);
          await SharedPrefsHelper.setEmail(email);
          await SharedPrefsHelper.setPassword(password);
          if (data['is_admin'] == 1) {
            _isAdmin = true;
          }
          await SharedPrefsHelper.setIsAdmin(_isAdmin);

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

  Future<void> updateEmail(String newEmail) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Ensure the current email is not null
      if (_email == null) {
        throw Exception("Current email is not available.");
      }

      final response = await http.post(
        Uri.parse('$_baseUrl/update_profile.php'),
        body: {
          'email': _email!, // Current email
          'new_email': newEmail,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          // Update local email
          _email = newEmail;
          await SharedPrefsHelper.setEmail(
              newEmail); // Save new email to SharedPreferences
          _errorMessage = null;
        } else {
          _errorMessage = data['message'] ?? 'Email update failed!';
        }
      } else {
        _errorMessage = 'Server error: ${response.statusCode}';
      }
    } catch (error) {
      _errorMessage = "Email update failed: ${error.toString()}";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUsername(String newUsername) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Ensure the current email is not null
      if (_email == null) {
        throw Exception("Current email is not available.");
      }

      final response = await http.post(
        Uri.parse('$_baseUrl/UsernameUpdate.php'),
        body: {
          'email': _email!, // Current email
          'username': newUsername,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          // Update local username
          _username = newUsername;
          await SharedPrefsHelper.setUsername(
              newUsername); // Save new username to SharedPreferences
          _errorMessage = null;
        } else {
          _errorMessage = data['message'] ?? 'Username update failed!';
        }
      } else {
        _errorMessage = 'Server error: ${response.statusCode}';
      }
    } catch (error) {
      _errorMessage = "Username update failed: ${error.toString()}";
      print(_errorMessage);
      print(_username);
      print(_email);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Ensure the current email is not null
      if (_email == null) {
        throw Exception("Current email is not available.");
      }

      final response = await http.post(
        Uri.parse('$_baseUrl/updatepass.php'),
        body: {
          'email': _email!, // Current email
          'current_password':
              currentPassword, // Current password for verification
          'password': newPassword, // New password
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          // Update local password
          _password = newPassword;
          _errorMessage = null;
        } else {
          _errorMessage = data['message'] ?? 'Password update failed!';
        }
      } else {
        _errorMessage = 'Server error: ${response.statusCode}';
      }
    } catch (error) {
      _errorMessage = "Password update failed: ${error.toString()}";
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
