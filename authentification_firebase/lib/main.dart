import 'package:authentication_firebase/screen/Auth.dart';
import 'package:authentication_firebase/screen/home_screen.dart';
import 'package:authentication_firebase/screen/login_screen.dart';
import 'package:authentication_firebase/screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyAy8gHvABjdZbxBKRsd-KRlk5cTQE5-nyQ",
      appId: "1:664166322415:android:0ebc6bf377b213f6904b1a",
      messagingSenderId: "664166322415",
      projectId: "fir-auth-app-9e046",
    ),
  );
  /*try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  } catch (e) {
    print('Error initializing Firebase: $e');
  */
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const Auth(),
      routes: {
        '/':(context)=>const Auth(),
        'home':(context)=>const HomeScreen(),
        'signup':(context)=> const SignupScreen(),
        'signin':(context)=>const LoginScreen()
      },
    );
  }
}

