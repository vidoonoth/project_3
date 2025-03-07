import 'package:flutter/material.dart';
import 'package:perpus_flutter/screens/buku.dart';
import 'package:perpus_flutter/screens/informasi.dart';
import 'package:perpus_flutter/screens/pengusulan.dart';
import 'package:perpus_flutter/screens/profil.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/dashboard.dart';
import 'screens/splash_screen.dart';
// import 'package:perpus_flutter/pages/bottom_nav_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Pengusulan Buku",
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/', // Pastikan sesuai dengan rute di bawah
      routes: {
        '/': (context) => SplashScreen(),
        '/login':
            (context) =>
                LoginPage(), // Sesuaikan dengan nama class di login.dart
        '/register':
            (context) =>
                RegisterScreen(), // Sesuaikan dengan nama class di register.dart
        '/dashboard':
            (context) =>
                DashboardScreen(), // Sesuaikan dengan nama class di dashboard.dart
        '/buku': (context) => BukuScreen(),
        '/usulan': (context) => Pengusulan(),
        '/informasi': (context) => Informasi(),
        '/profil': (context) => Profil(),
      },
      // home: BottomNavScreen(),
    );
  }
}
