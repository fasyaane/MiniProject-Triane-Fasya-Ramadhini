import 'package:flutter/material.dart';
import 'package:notesapp/data_source/firebase_data_source.dart';
import 'package:notesapp/pages/notes.dart';
import 'register.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

Future<void> logIn() async {
  final FirebaseDataSource _dataSource = FirebaseDataSource();

  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: usernameController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (userCredential.user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => NoteListScreen(),
        ),
      );
    } else {
      // kalo mau dihapus hapus aja line ini
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color(0xFF8ABCD7), // Ganti warna latar belakang di sini
            title: Text('Login Gagal', style: TextStyle(color: Colors.white)), // Ganti warna teks title
            content: const Text(
              'Email atau kata sandi salah. Silakan coba lagi.',
              style: TextStyle(color: Colors.white), // Ganti warna teks content
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK', style: TextStyle(color: Colors.white)), // Ganti warna teks button
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
// sampe sini hapusnya 
  } on FirebaseAuthException catch (e) {
    // disini neu kalo user salah login
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color(0xFF8ABCD7), // Ganti warna latar belakang di sini
            title: Text('Login Gagal', style: TextStyle(color: Colors.white)), // Ganti warna teks title
            content: const Text(
              'Email atau kata sandi salah. Silakan coba lagi.',
              style: TextStyle(color: Colors.white), // Ganti warna teks content
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK', style: TextStyle(color: Colors.white)), // Ganti warna teks button
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
  }
}





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8ABCD7),
        automaticallyImplyLeading: false, // Menghapus tombol kembali
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 70.0,
                ),
                child: Image.asset(
                  'assets/logonotesapp.png',
                  width: 150,
                  height: 150,
                ),
              ),
              const SizedBox(
                height: 80.0,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20.0,
                  ),
                  child: Text(
                    'MASUK',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8ABCD7),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 30,
                    ),
                    child: Text(
                      'Email',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3F658B),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      width: 500,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFF7EAAC9),
                      ),
                      child: TextField(
                        controller: usernameController,
                        decoration: const InputDecoration(
                          hintText: "Email",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Text(
                      'Kata Sandi',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3F658B),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      width: 500,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFF7EAAC9),
                      ),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Kata Sandi",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 30, // Mengurangi jarak vertikal dengan tombol Login
                    ),
                    child: Align(
                      alignment:
                          Alignment.center, // Supaya tombol login ditengah
                      child: SizedBox(
                        width: 500,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            logIn();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF7EAAC9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Masuk',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top:
                          10, // Mengurangi jarak vertikal dengan tombol Registrasi
                    ),
                    child: Align(
                      alignment:
                          Alignment.center, // agar posisi tombol di tengah
                      child: SizedBox(
                        width: 500,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF7EAAC9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Registrasi',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}