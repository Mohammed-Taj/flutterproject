import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/provider/theme_provider.dart';

import '../../../constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: screenWidth > 400 ? 2 : 3,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: SwitchListTile(
                key: ValueKey<bool>(themeNotifier.isDarkMode),
                contentPadding: EdgeInsets.zero,
                title: Text(
                  themeNotifier.isDarkMode ? 'Dark Mode' : 'Light Mode',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                value: themeNotifier.isDarkMode,
                activeColor: Theme.of(context).colorScheme.primary,
                onChanged: (value) {
                  themeNotifier.toggleTheme(value);
                },
              ),
            ),
          ),
          const Spacer(),
          _buildIconButton(
            context,
            icon: Image.asset(
              "images/icon.png",
              height: 24,
              width: 24,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            onPressed: () {
              // Add your action here
            },
          ),
          const SizedBox(width: 12),
          _buildIconButton(
            context,
            icon: Icon(
              Icons.notifications_outlined,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            onPressed: () {
              // Add your action here
            },
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(BuildContext context,
      {required Widget icon, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: kcontentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(12),
        elevation: 5,
        shadowColor: Colors.black.withOpacity(0.1),
      ),
      child: icon,
    );
  }
}
