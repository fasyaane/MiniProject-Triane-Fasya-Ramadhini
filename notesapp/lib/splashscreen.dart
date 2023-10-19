import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/logonotesapp.png', // Ganti dengan nama gambar Anda
          width: 200, // Lebar gambar
          height: 200, // Tinggi gambar
        ),
      ),
    );
  }
}
