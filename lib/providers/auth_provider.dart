import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/screens/products%20overview%20screen.dart';
import 'package:shop_app/utils/utils.dart';

class Authentication with ChangeNotifier {
  String _email;
  String _password;
  String _userName;
  String _fullName;
  bool _isSignedIn = false;
  String _personal_uid;

  Authentication() {
    FirebaseFirestore.instance.collection('users').get().then((QuerySnapshot querySnapshot) => {
          querySnapshot.docs.forEach((element) {
            //TODO  get User info  from Firebase Store
          })
        });
  }

  String get email {
    return _email;
  }

  Stream<User> get user => FirebaseAuth.instance.authStateChanges();

  String get refreshToken {
    return _personal_uid;
  }

  String get userName {
    return _userName;
  }

  String get fullName {
    return _fullName;
  }

  String get password {
    return _password;
  }

  bool get isAuthenticated {
    return _isSignedIn;
  }

  Future<void> signUp(CollectionReference users, String email, String password, String fullName, String userName, BuildContext context) async {
    UserCredential userCredential;
    try {
      userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).whenComplete(() {
        authState(context);
        if (_isSignedIn) {
          _email = email;
          _userName = userName;
          _fullName = fullName;
          Navigator.pushReplacementNamed(context, ProductsOverview.routeName);
          uploadUserInfo(users, email, fullName, userName, _personal_uid);
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, "password is too weak!");
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, "This email  address is already in use!");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signIn(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .whenComplete(() async {
        authState(context);
        if (_isSignedIn) {
          print(_personal_uid);
          _email = email;
          _userName = userName;
          _fullName = fullName;
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, "No user found!");
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, "Wrong password!");
      } else if (e.code == 'wrong-email') {
        showSnackBar(context, "Wrong email!");
      }
    }
    notifyListeners();
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      showSnackBar(context, "Error, try again!");
    }
    notifyListeners();
  }

  void deleteAccount() {}

  void resetPassword() {}

  void authState(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        _isSignedIn = false;

        //showSnackBar(context, "current state:  not authenticated!");
      } else {
        _personal_uid = user.uid;
        _isSignedIn = true;
        Navigator.pushReplacementNamed(context, ProductsOverview.routeName);
        showSnackBar(context, "current state:  authenticated!");
      }
    });
    notifyListeners();
  }

  Future<void> uploadUserInfo(CollectionReference users, String email, String fullName, String userName, String sessionKey) async {
    users.add({"email": email, "fullName": fullName, "userName": userName, "sessionKey": sessionKey});
    notifyListeners();
  }
}
