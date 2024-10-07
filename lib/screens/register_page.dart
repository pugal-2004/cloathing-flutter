import 'package:cloth/AllCategories/mt_button.dart';
import 'package:cloth/AllCategories/my_textfield.dart';
import 'package:cloth/auth/auth_service.dart';
import 'package:flutter/material.dart';


class RegisterPage extends StatelessWidget {
  //email and password controller
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _confirmController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
 
//redirect to login page

final void Function()? onTap;

   RegisterPage({super.key, required this.onTap});

   //register Method
   void register(BuildContext context){
    final auth = AuthService();

    //password match -> create user
    if (_passwordController.text==_confirmController.text){
      try{
        auth.signUpWithEmailPasssword(
         _emailController.text,
          _passwordController.text
          );
      }catch (e){
        showDialog(context: context, builder:(context)=>AlertDialog(
          title: Text(e.toString()),
        )
        );
      }
    }
    //password doesn't match
    //showDialog(context: context, builder:(context)=>const AlertDialog(
         // title: Text("password match"),));
      
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.message_rounded,
              size: 60,
              color:Theme.of(context).colorScheme.primary,
            ),
            const SizedBox( height: 20,),
            //Welcome 
            Text(
              "Let's create an Account",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
              ),
            ),
            const SizedBox( height: 25,),
            //email TextField
            MyTextField(hintText: "Email",
            obscureText: false,
            controller: _emailController,
            ),
            

            const SizedBox( height: 25,),

            //pswd TextField
            MyTextField(hintText: "password",
            obscureText: true,
            controller: _passwordController ,
            ),
            const SizedBox( height: 25,),

            //cnfmpswd TextField
            MyTextField(hintText: "confirm password",
            obscureText: true,
            controller: _confirmController,
            ),


           const SizedBox(height: 25,),


            //login btn
            MyButton(
              text: "Register",
              onTap:()=> register(context),
            ),
            const SizedBox(height: 25,),

            //Not a member
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                GestureDetector(
                  onTap: onTap,
                  child: const Text("Login Now",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )

         
        
        
        
        
        
        
        
        
          ],
        ),
      ),
    );
  }
}