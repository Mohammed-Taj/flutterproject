import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  String? _username; // Store the username locally

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get username => _username;

  Future<void> register(String username, String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Call your registration API here
      // Example: await apiService.register(username, email, password);
      await Future.delayed(Duration(seconds: 2)); // Mock API call

      // If successful, save the username locally
      _username = username;
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _errorMessage = "Registration failed: ${error.toString()}";
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Call your login API here
      // Example: await apiService.login(email, password);
      await Future.delayed(Duration(seconds: 2)); // Mock API call

      // If successful, retrieve and store the username from the API response
      _username = "User"; // Replace with the actual username from API response
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _errorMessage = "Login failed: ${error.toString()}";
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfile(String newUsername, String newPassword) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Call your update profile API here
      // Example: await apiService.updateProfile(newUsername, newPassword);
      await Future.delayed(Duration(seconds: 2)); // Mock API call

      // If successful, update the local username
      _username = newUsername;
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _errorMessage = "Profile update failed: ${error.toString()}";
      _isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    _username = null;
    _errorMessage = null;

    // Clear any saved tokens or session details
    // Example: apiService.logout();

    notifyListeners();
  }
}
