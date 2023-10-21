// database_service.dart
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'notes.dart';

class DatabaseService {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

  Future<void> saveUserData(String userId, String username, String email) async {
    await _databaseReference.child('users').child(userId).set({
      'username': username,
      'email': email,
    });
  }

 Future<Object?> getUserData(String userId) async {
  DataSnapshot dataSnapshot = (await _databaseReference.child('users').child(userId).once()) as DataSnapshot;
  Object? userData = dataSnapshot.value;
  return userData;
}

}
