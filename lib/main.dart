import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop/constants.dart';
import 'package:shop/provider/HomeProvider.dart';
import 'package:shop/provider/auth_provider.dart';
import 'package:shop/provider/add_to_cart_provider.dart';
import 'package:shop/provider/favorite_provider.dart';
import 'package:shop/provider/theme_provider.dart';
import 'package:shop/screens/Login_screen.dart';
import 'package:shop/screens/Register_screen.dart';
import 'package:shop/screens/nav_bar_screen.dart';
import 'package:shop/shared/shared_prefs_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isLoggedIn = await SharedPrefsHelper.isLoggedIn();

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: kprimaryColor,
              scaffoldBackgroundColor: kcontentColor,
              appBarTheme: AppBarTheme(
                backgroundColor: kprimaryColor,
                iconTheme: const IconThemeData(color: Colors.white),
                titleTextStyle:
                    const TextStyle(color: Colors.white, fontSize: 20),
              ),
              textTheme: GoogleFonts.mulishTextTheme(),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Colors.black,
              scaffoldBackgroundColor: Colors.grey[900],
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.black,
                iconTheme: const IconThemeData(color: Colors.white),
                titleTextStyle:
                    const TextStyle(color: Colors.white, fontSize: 20),
              ),
              textTheme: GoogleFonts.mulishTextTheme(),
            ),
            initialRoute: isLoggedIn ? '/nav-bar' : '/login',
            routes: {
              '/login': (context) => LoginScreen(),
              '/nav-bar': (context) => BottomNavBar(),
              '/register': (context) => RegisterScreen(),
            },
          );
        },
      ),
    );
  }
}
