import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  int _currentSlider = 0;
  int _selectedIndex = 0;

  int get currentSlider => _currentSlider;
  int get selectedIndex => _selectedIndex;

  void updateSlider(int index) {
    _currentSlider = index;
    notifyListeners();
  }

  void updateCategory(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
