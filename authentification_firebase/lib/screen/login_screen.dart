import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
  String? _signInError;
  Future signIn() async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // Clear any previous sign-in errors
      setState(() {
        _signInError = null;
      });
    } catch (e) {
      setState(() {
        // Set the error message based on the sign-in exception
        _signInError = 'Sign-in failed. Please check your credentials.';
      });
    }
  }

  void openSignup(){
    Navigator.of(context).pushReplacementNamed("signup");
  }
  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body:SafeArea(
          child:Center(
              child :SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/user.png',height: 150,),
                    SizedBox(height: 5,),
                    Text(
                        'SIGN IN',
                        style: GoogleFonts.robotoCondensed(
                          fontSize: 40,
                          fontWeight: FontWeight.bold
                        ),
                    ),
                    Text(
                      'Welcome,Please Sign In',
                      style: GoogleFonts.robotoCondensed(
                          fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 50,),
                    if (_signInError != null) // Display the error if it exists
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _signInError!,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email"
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                
                                border: InputBorder.none,
                                hintText: "Password"
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: GestureDetector(
                        onTap: signIn,
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.amber[900],
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: Center(
                              child: Text("Sign in",
                              style: GoogleFonts.robotoCondensed(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                              )
                              )
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Not yet a memeber? "),
                        GestureDetector(
                          onTap: openSignup,
                          child: Text("Sign up Now",
                          style: GoogleFonts.robotoCondensed(
                            color: Colors.green,
                            fontWeight: FontWeight.bold
                          ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
          ),

      ),
    );
  }
}
