import 'package:cloth/auth/auth_service.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
  });

  void logout(){
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          
          SizedBox(
            height: 30,
            width: 30,
            child: Image.asset('assets/icons/menu.png', color: Colors.white,),
          ),
         Padding(
          padding: const EdgeInsets.only(left: 250 ),
          child: IconButton(onPressed: logout, icon: const Icon(Icons.logout))),
          const CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('assets/images/profile.jpg'),
          ),
        ],
      ),
    );
  }
}
