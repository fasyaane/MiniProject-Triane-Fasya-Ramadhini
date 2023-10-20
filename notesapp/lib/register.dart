import 'package:flutter/material.dart';


class RegisterScreen extends StatelessWidget {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8ABCD7),
        title: Text('Register'), // Ganti judul sesuai kebutuhan
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
                  'assets/your_logo.png', // Ganti dengan path logo Anda
                  width: 150,
                  height: 150,
                ),
              ),
              SizedBox(
                height: 80.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20, // Sesuaikan jarak vertikal dengan input username
                    ),
                    child: Text(
                      'Username',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3F658B),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      width: 500,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF7EAAC9),
                      ),
                      child: TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          hintText: "Username",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10, // Sesuaikan jarak vertikal antara teks 'Username' dan 'Email'
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
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
                    padding: EdgeInsets.all(20),
                    child: Container(
                      width: 500,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF7EAAC9),
                      ),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10, // Sesuaikan jarak vertikal antara teks 'Email' dan 'Password'
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Text(
                      'Password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF3F658B),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      width: 500,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF7EAAC9),
                      ),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 40, // Sesuaikan jarak vertikal dengan tombol Register
                    ),
                    child: Align(
                      alignment: Alignment.center, // Posisikan tombol di tengah
                      child: SizedBox(
                        width: 500,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // Tambahkan logika untuk menghandle proses registrasi di sini
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF7EAAC9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Register',
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