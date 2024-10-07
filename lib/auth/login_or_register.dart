import 'package:cloth/screens/login_page.dart';
import 'package:cloth/screens/register_page.dart';
import 'package:flutter/material.dart';



class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {

//initially show login page

bool showLoginPage=true;
 
 //toggle btwn login & register

 void togglepages(){
 setState(() {
    showLoginPage=!showLoginPage;
 });
 }



  @override
  Widget build(BuildContext context) {
    if (showLoginPage){
      return LoginPage(
        onTap: togglepages,
      );
    } else{
      return RegisterPage(
         onTap: togglepages,
      );
    }
  }
}