import 'package:flutter/material.dart';
import 'database_service.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beranda'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Tambahkan logika untuk logout di sini
              // Setelah logout, Anda dapat mengarahkan pengguna kembali ke halaman login atau halaman lain yang sesuai.
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Selamat datang di halaman beranda!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
