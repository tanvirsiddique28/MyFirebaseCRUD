import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_firebase_auth_crud/auth_pages/login_page.dart';
import 'package:my_firebase_auth_crud/pages/home_page/home_page.dart';
import 'package:my_firebase_auth_crud/services/toast_services/show_toast.dart';
import '../services/firebase_services/firebase_auth_services/firbase_auth_service.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  FirebaseAuthService _authService = FirebaseAuthService();

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool isSignUp = false;

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('SignUp',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 27),),
              SizedBox(height: 30,),
              TextFormField(
                controller: _userNameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
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
                    signUp();
                },
                child: Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(child: isSignUp?CircularProgressIndicator(color: Colors.white):Text('SignUp',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Do you have account?"),
                  SizedBox(width: 5,),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LogInPage()), (route) => false);
                    },
                      child: Text("Log In",style: TextStyle(color: Colors.blue,),)
                  ),
                ],
              )

            ],
          ),
        ),
    );
  }

  void signUp() async{

    setState(() {
      isSignUp = true;
    });

    String userName = _userNameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _authService.siginUpWithEmailAndPassword(email, password);

    setState(() {
      isSignUp = false;
    });

    if(user != null){
      showToast(message: 'user is successfully created');
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
    }else{
      print('an error occured');
    }


  }
}
