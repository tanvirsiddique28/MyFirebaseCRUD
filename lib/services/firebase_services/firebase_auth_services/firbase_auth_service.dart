import 'package:firebase_auth/firebase_auth.dart';

import '../../toast_services/show_toast.dart';

class FirebaseAuthService{

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> siginUpWithEmailAndPassword(String email,String password) async{

    try{
      UserCredential _userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return _userCredential.user;
    }on FirebaseException catch(e){
      if(e.code == 'email-already-in-use'){
        showToast(message: 'The email address is already in use');
      }else{
        showToast(message: 'An error occurred $e');
      }
    }
    return null;

  }

  Future<User?> logInWithEmailAndPassword(String email,String password)async{

    try{
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _userCredential.user;
    }on FirebaseException catch(e){
      if(e.code == 'user-not-found' || e.code == 'wrong-password'){
          showToast(message: "Invalid email and password");
      }else{
        showToast(message:'An error occurred: ${e.code}');
      }
    }
    return null;

  }
}