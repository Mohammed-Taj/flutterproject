import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop/constants.dart';
import 'package:shop/provider/HomeProvider.dart';
import 'package:shop/provider/auth_provider.dart';
import 'package:shop/provider/add_to_cart_provider.dart';
import 'package:shop/provider/favorite_provider.dart';
import 'package:shop/screens/Login_screen.dart';
import 'package:shop/screens/Register_screen.dart';
import 'package:shop/screens/nav_bar_screen.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kprimaryColor,
          scaffoldBackgroundColor: kcontentColor,
          appBarTheme: AppBarTheme(
            backgroundColor: kprimaryColor,
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: kprimaryColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: kprimaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: kprimaryColor, width: 2),
            ),
            labelStyle: TextStyle(color: kprimaryColor),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kprimaryColor,
              foregroundColor: kcontentColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: kprimaryColor,
            ),
          ),
          textTheme: GoogleFonts.mulishTextTheme(),
        ),
        initialRoute: '/register',
        routes: {
          '/login': (context) => LoginScreen(),
          '/nav-bar': (context) => BottomNavBar(),
          '/register': (context) => RegisterScreen(),
        },
      ),
    );
  }
}
