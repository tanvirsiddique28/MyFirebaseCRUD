import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_firebase_auth_crud/auth_pages/signup_page.dart';
import 'package:my_firebase_auth_crud/pages/home_page/home_page.dart';
import 'package:my_firebase_auth_crud/services/firebase_services/firebase_auth_services/firbase_auth_service.dart';
import 'package:my_firebase_auth_crud/services/toast_services/show_toast.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {

  FirebaseAuthService _authService = FirebaseAuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool isSignIn = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LogIn'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('LogIn',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 27),),
                SizedBox(height: 30,),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 30,),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 30,),
                GestureDetector(
                  onTap: (){
                    logIn();
                  },
                  child: Container(
                    height: 45,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(child:isSignIn?CircularProgressIndicator(color: Colors.white):Text('LogIn',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Dont't have an account?",),
                    SizedBox(width: 5,),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()),);
                      },
                        child: Text("Sign Up",style: TextStyle(color: Colors.blue),)
                    ),
                  ],
                )
              ],
            ),
          ),
      ),
    );
  }

  void logIn() async{

    setState(() {
      isSignIn = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _authService.logInWithEmailAndPassword(email, password);

    setState(() {
      isSignIn = false;
    });

    if(user != null){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
      showToast(message: 'User is successfully logged in');
    }else{
      showToast(message: 'an error occurred');
    }
  }
}
