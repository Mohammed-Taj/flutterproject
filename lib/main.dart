import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/admen/AddProductScreen.dart';
import 'package:shop/admen/DisplayProductsScreen.dart';
import 'package:shop/onboarding.dart';
import 'package:shop/provider/HomeProvider.dart';
import 'package:shop/provider/OnboardingProvider.dart';
import 'package:shop/provider/auth_provider.dart';
import 'package:shop/provider/add_to_cart_provider.dart';
import 'package:shop/provider/favorite_provider.dart';
import 'package:shop/provider/theme_provider.dart';
import 'package:shop/screens/login/Login_screen.dart';
import 'package:shop/screens/Register/Register_screen.dart';
import 'package:shop/screens/nav_bar_screen.dart';
import 'package:shop/shared/shared_prefs_helper.dart';
import 'package:shop/utils/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check if the user is logged in
  final isLoggedIn = await SharedPrefsHelper.isLoggedIn();
  final isAdmen = await SharedPrefsHelper.isAdmin();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
      ],
      child: MyApp(isLoggedIn: isLoggedIn, isAdmen: isAdmen),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final bool isAdmen;

  const MyApp({super.key, required this.isLoggedIn, required this.isAdmen});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeNotifier.themeMode, // Theme based on ThemeNotifier
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialRoute: isLoggedIn
          ? (isAdmen ? '/DisplayProductsScreen' : '/nav-bar')
          : '/onboarding',
      // initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/nav-bar': (context) => BottomNavBar(),
        '/register': (context) => RegisterScreen(),
        '/onboarding': (context) => OnboardingScreen(),
        // '/Verification': (context) => Verification(),
        '/AddProductScreen': (context) => AddProductScreen(),
        '/DisplayProductsScreen': (context) => DisplayProductsScreen(),
      },
    );
  }
}
