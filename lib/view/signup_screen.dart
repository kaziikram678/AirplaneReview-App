import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/view/UI_helper.dart';
import 'package:socialapp/main.dart';
import 'package:socialapp/view/news_feed_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  signUp(String email, String password)async
  {
    if(email=="" && password==""){
      Uihelper.CustomAlertBox(context, "Enter Required Fields");
    }
    else {
      UserCredential? usercredential;
      try {
        usercredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsFeedPage()));
        
      } on FirebaseAuthException catch (ex) {
        return Uihelper.CustomAlertBox(context, ex.code.toString());
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Sign Up Page"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Uihelper.CustomTextField(emailController, "Email", Icons.email, false),
          SizedBox(height: 10,),
          Uihelper.CustomTextField(passwordController, "Password", Icons.password, true),
          SizedBox(height: 30,),
          Uihelper.CustomButton((){
            signUp(emailController.text.toString(), passwordController.text.toString());
          }, "Sign Up"),
        ],
      ),
    );
  }
}