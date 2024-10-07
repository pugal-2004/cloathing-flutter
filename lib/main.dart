import 'package:cloth/auth/auth_gate.dart';
import 'package:cloth/firebase_options.dart';
import 'package:cloth/home/components/order_provider.dart';
import 'package:cloth/home_page.dart';
import 'package:cloth/screens/home_screen/orderpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => OrderProvider()), // Adding OrderProvider
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
        ),
        home: const AuthGate(), 
        routes: {
          '/orders': (context) => OrdersPage(), 
          '/home': (context) => const HomePage(),
        },
      ),
    );
  }
}
