import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingProvider with ChangeNotifier {
  bool _isOnboardingCompleted = false;

  bool get isOnboardingCompleted => _isOnboardingCompleted;

  Future<void> loadOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isOnboardingCompleted = prefs.getBool('isOnboardingCompleted') ?? false;
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isOnboardingCompleted', true);
    _isOnboardingCompleted = true;
    notifyListeners();
  }
}
