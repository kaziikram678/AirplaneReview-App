import 'package:flutter/material.dart';
import 'package:socialapp/constants/routes.dart';
import 'package:socialapp/services/auth_service.dart';
import 'package:socialapp/view/login_screen.dart';
import 'package:socialapp/view/news_feed_screen.dart';
import 'package:socialapp/view/register_view.dart';
import 'package:socialapp/view/verify_email.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  //WidgetsFlutterBinding();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: NewsFeedPage(),
    // routes: {
    //   loginRoute: (context) => const LoginView(),
    //   registerRoute: (context) => const RegisterView(),
    //   verifyEmailRoute: (context) => const VerifyEmailView(),
      
    // },
  ));
}




