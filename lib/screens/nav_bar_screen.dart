import 'package:flutter/material.dart';
import 'package:shop/constants.dart';
import 'package:shop/screens/Cart/cart_screen.dart';
import 'package:shop/screens/Favorite/favorite_screen.dart';
import 'package:shop/screens/Home/home_screen.dart';
import 'package:shop/screens/Profile/profile.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 2; // Default index for HomeScreen

  final Map<int, Widget> screens = {
    0: Scaffold(),
    1: Favorite(),
    2: HomeScreen(),
    3: CartScreen(),
    4: UserProfileScreen(),
  };

  void _onNavItemSelected(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void _onFabPressed() {
    setState(() {
      currentIndex = 2; // Reset to HomeScreen on FAB press
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _onFabPressed,
        shape: const CircleBorder(),
        backgroundColor: kprimaryColor,
        child: const Icon(
          Icons.home,
          color: Colors.white,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        height: 60,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(0, Icons.grid_view_outlined),
            _buildNavItem(1, Icons.favorite_border),
            const SizedBox(width: 15), // Spacer for FAB
            _buildNavItem(3, Icons.shopping_cart_outlined),
            _buildNavItem(4, Icons.person),
          ],
        ),
      ),
      body: screens[currentIndex]!,
    );
  }

  Widget _buildNavItem(int index, IconData icon) {
    return IconButton(
      onPressed: () => _onNavItemSelected(index),
      icon: Icon(
        icon,
        size: 30,
        color: currentIndex == index ? kprimaryColor : Colors.grey.shade400,
      ),
    );
  }
}
