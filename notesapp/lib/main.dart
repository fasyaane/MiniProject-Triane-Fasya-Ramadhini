import 'package:flutter/material.dart';
import 'splashscreen.dart'; // Impor widget SplashScreen yang telah Anda buat
import 'login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), // Gunakan widget SplashScreen sebagai splash screen
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: Future.delayed(
              Duration(seconds: 3), () => 'data'), // Timer 3 detik
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // Navigasi ke halaman login setelah timer selesai
              return LoginScreen(); // Gantilah dengan widget halaman login Anda
            } else {
              return Center(
                child: Image.asset(
                  'assets/logonotesapp.png', // Ganti dengan path gambar Anda
                  width: 200, // Lebar gambar
                  height: 200, // Tinggi gambar
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
