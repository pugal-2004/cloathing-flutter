
import 'package:cloth/auth/login_or_register.dart';
import 'package:cloth/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot)  {
          //user logged In 
          if (snapshot.hasData){
            return const HomePage();
          }

          //user is Not Logged In
          else{
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}