import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference();

  Future<void> saveUserData(
      String userId, String username, String email) async {
      await _databaseReference.child('users').child(userId).set({
      'username': username,
      'email': email,
    });
  }
  Future<Object?> getUserData(String userId) async {
    DataSnapshot dataSnapshot = (await _databaseReference
        .child('users')
        .child(userId)
        .once()) as DataSnapshot;
    Object? userData = dataSnapshot.value;
    return userData;
  }
}
