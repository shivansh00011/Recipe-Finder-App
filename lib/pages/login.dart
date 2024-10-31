import 'package:dishcovery/pages/forgotpassword.dart';
import 'package:dishcovery/pages/home.dart';
import 'package:dishcovery/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "", password = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // To display loading spinner during login
  bool isLoading = false;

  // Firebase Authentication Method for Sign In
  Future<void> loginUser() async {
    setState(() {
      isLoading = true; // Start loading spinner
    });

    try {
      // Firebase authentication for signing in with email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Navigate to HomePage on successful login
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomePage()));

    } catch (e) {
      // Display an error message if sign in fails
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid credentials. Please try again."),
        ),
      );
    } finally {
      setState(() {
        isLoading = false; // Stop loading spinner
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 230),
              child: Text("DishCovery",
                  style: GoogleFonts.dynaPuff(
                      fontSize: 39, fontWeight: FontWeight.w700)),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Container(
                height: 400,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20, right: 20, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                          child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white, fontSize: 23),
                      )),
                      const SizedBox(height: 25),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.person_2_outlined,
                            color: Colors.white,
                          ),
                          hintText: 'Enter your email',
                          hintStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 25),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          hintText: 'Enter your password',
                          hintStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 30),
                      isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : GestureDetector(
                              onTap: loginUser,
                              child: Container(
                                height: 60,
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(16)),
                                child: Center(
                                  child: Text("Login",
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white, fontSize: 18)),
                                ),
                              ),
                            ),
                      const SizedBox(height: 25),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ForgotPassword()));
                        },
                        child: const Padding(
                            padding: EdgeInsets.only(left: 210),
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(_createRoute());
                },
                child: Center(
                    child: Text("Don't have an account?",
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)))),
          ],
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const RegisterPage(),
    transitionsBuilder:
        (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}
