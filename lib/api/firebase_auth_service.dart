import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_recipe_app/api/firestore_service.dart';

final firebaseAuthServiceProvider = Provider((ref) {
  return FirebaseAuthService(ref.read(firebaseAuth));
},);

final firebaseAuth = Provider((ref) => FirebaseAuth.instance);

class FirebaseAuthService {
  final FirebaseAuth firebaseAuth;
  FirebaseAuthService(this.firebaseAuth);
  
  Future signIn({required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print('error: $e');
    }
  }

  Future signUp(
      {required String email,
      required String password,
      required String userName}) async {
    try {
      final user = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await user.user?.updateProfile(displayName: userName);
      print(FirebaseAuth.instance.currentUser);
      FirestoreService()
          .addUser(email: email, name: userName.isEmpty ? 'User' : userName, uid: user.user!.uid);
    } catch (e) {
      print('error: $e');
    }
  }

  Future signOut() async{
    await firebaseAuth.signOut();
  }
}
