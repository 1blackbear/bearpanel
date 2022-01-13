import 'dart:async';
import 'package:bearpanel/models/disciplin.dart';
import 'package:bearpanel/models/user.dart';
import 'package:bearpanel/screens/authenticate/sing_in.dart';
import 'package:bearpanel/screens/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'database.dart';


abstract class AuthBase {
  User get currentUser;
  Future signInWithGoogle();
  Future signInWithFacebook();
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user_state;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      user_state = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  _getUser() {
    user_state = _auth.currentUser;
    notifyListeners();
  }


  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (!(user!.emailVerified)) {
        return 2;
      } else {
        _getUser();
      }
    } on FirebaseAuthException catch  (e) {
      print('Failed with error code: ${e.code}');
      if (e.code == 'wrong-password') {
        return 1;
      }
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(
      String email, String password, String nome, String course_name, int periods) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      //create a document for the user with the uid
      await DatabaseService(uid: user!.uid).updateUserData(nome, [], course_name, periods);
      user.sendEmailVerification();
      _getUser();
    } on FirebaseAuthException catch  (e) {
      print('Failed with error code: ${e.code}');
      if (e.code == 'email-already-in-use') {
        return 1;
      }
    }
  }



  //sing out
  Future signOut() async {
    try {
      await _auth.signOut();
      _getUser();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Reset password
  Future sendPasswordResetEmail(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  //sign in with google
  Future signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _auth.signInWithCredential(
            GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken));
        User? user = userCredential.user;
        if (userCredential.additionalUserInfo!.isNewUser) {
          String nome = user != null ? user.displayName.toString() : "";
          await DatabaseService(uid: user!.uid).updateUserData(nome, [], '', 8);
          //User logging in for the first time
          // Redirect user to tutorial
        }
        _getUser();
      }
    }
  }

  //sign in with facebook
  Future signInWithFacebook() async {
    final fb = FacebookLogin();
    final response = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (response.status) {
      case FacebookLoginStatus.success:
        final accessToken = response.accessToken;
        final userCredential = await _auth.signInWithCredential(FacebookAuthProvider.credential(accessToken!.token));
        User? user = userCredential.user;
        if (userCredential.additionalUserInfo!.isNewUser) {
          String nome = user != null ? user.displayName.toString() : "";
          await DatabaseService(uid: user!.uid).updateUserData(nome, [], '', 8);//User logging in for the first time
          // Redirect user to tutorial
        }
        _getUser();
        break;
      case FacebookLoginStatus.cancel:
        throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      case FacebookLoginStatus.error:
        throw FirebaseAuthException(
          code: 'ERROR_FACEBOOK_LOGIN_FAILED',
          message: response.error!.developerMessage,
        );
      default:
        throw UnimplementedError();
    }
  }
}



