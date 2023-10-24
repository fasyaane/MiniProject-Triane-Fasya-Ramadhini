import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/pages/login.dart';
import 'package:notesapp/pages/notes.dart';

class LoggedInHandler extends StatefulWidget {
  const LoggedInHandler({super.key});

  @override
  State<LoggedInHandler> createState() => _LoggedInHandlerState();
}

class _LoggedInHandlerState extends State<LoggedInHandler> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('something went wrong'),
          );
        } else if (snapshot.hasData) {
          return NoteListScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
