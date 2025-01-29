import 'package:flutter/material.dart';
import 'package:shop/constants.dart';
import 'package:shop/screens/Cart/cart_screen.dart';
import 'package:shop/screens/Favorite/favorite_screen.dart';
import 'package:shop/screens/Home/home_screen.dart';
import 'package:shop/screens/Profile/profile.dart';

// Move the enum to the top level
enum NavItem { grid, favorite, home, cart, profile }

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  NavItem currentNavItem = NavItem.home; // Default to HomeScreen

  // Use a map to associate each NavItem with its corresponding screen
  final Map<NavItem, Widget> screens = {
    NavItem.grid: const Scaffold(), // Placeholder for grid view
    NavItem.favorite: const Favorite(),
    NavItem.home: const HomeScreen(),
    NavItem.cart: const CartScreen(),
    NavItem.profile: const UserProfileScreen(),
  };

  void _onNavItemSelected(NavItem navItem) {
    setState(() {
      currentNavItem = navItem;
    });
  }

  void _onFabPressed() {
    // Only reset to home if not already on home
    if (currentNavItem != NavItem.home) {
      setState(() {
        currentNavItem = NavItem.home;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: screens[currentNavItem],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onFabPressed,
        tooltip: 'Home', // Add a tooltip for better UX
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
            _buildNavItem(NavItem.grid, Icons.grid_view_outlined),
            _buildNavItem(NavItem.favorite, Icons.favorite_border),
            const SizedBox(width: 15), // Spacer for FAB
            _buildNavItem(NavItem.cart, Icons.shopping_cart_outlined),
            _buildNavItem(NavItem.profile, Icons.person),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(NavItem navItem, IconData icon) {
    return IconButton(
      onPressed: () => _onNavItemSelected(navItem),
      icon: Icon(
        icon,
        size: 30,
        color: currentNavItem == navItem ? kprimaryColor : Colors.grey.shade400,
      ),
    );
  }
}
