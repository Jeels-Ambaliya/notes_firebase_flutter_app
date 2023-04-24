import 'package:createnote_signin_signup_firebase/views/screens/home_page.dart';
import 'package:createnote_signin_signup_firebase/views/screens/login_page.dart';
import 'package:createnote_signin_signup_firebase/views/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xffb790dc),
      ),
      initialRoute: 'splash_screen',
      routes: {
        '/': (context) => const Home_Page(),
        'login_page': (context) => const Login_Page(),
        'splash_screen': (context) => const Splah_Screen(),
      },
    ),
  );
}
