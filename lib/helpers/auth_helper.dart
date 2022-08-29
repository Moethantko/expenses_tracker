import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthHelper {
  final _storage = const FlutterSecureStorage();

  void saveToken(UserCredential userCredential) async {
    await _storage.write(
        key: 'token', value: userCredential.credential?.token.toString());
    await _storage.write(key: 'email', value: userCredential.user?.email);
  }

  Future<UserCredential> signIn(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    saveToken(userCredential);

    return userCredential;
  }

  Future<UserCredential> signUp(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    saveToken(userCredential);

    return userCredential;
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  void deleteAccount(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    if (userCredential.user != null) {
      await userCredential.user!.delete();
    }
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }
}
