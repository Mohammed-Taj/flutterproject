import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  // Default to the system theme initially
  ThemeMode _themeMode = ThemeMode.system;

  // Get the current theme mode
  ThemeMode get themeMode => _themeMode;

  // Check if dark mode is active
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  // Constructor to initialize theme mode from shared preferences
  ThemeNotifier() {
    _loadThemeMode();
  }

  // Load the saved theme mode from shared preferences
  Future<void> _loadThemeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDark = prefs.getBool('isDarkMode') ?? false;
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
      notifyListeners(); // Notify listeners after loading
    } catch (e) {
      // Log or handle error if necessary
      debugPrint("Failed to load theme mode: $e");
    }
  }

  // Toggle the theme and save the preference
  Future<void> toggleTheme(bool isDark) async {
    try {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isDarkMode', isDark);
      notifyListeners(); // Notify listeners of the change
    } catch (e) {
      // Log or handle error if necessary
      debugPrint("Failed to toggle theme: $e");
    }
  }
}
