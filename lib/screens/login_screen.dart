// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_instagram/resources/auth_methods.dart';
import 'package:flutter_instagram/responsive/mobile_screen_layout.dart';
import 'package:flutter_instagram/responsive/responsive_layout.dart';
import 'package:flutter_instagram/screens/signup_screen.dart';
import 'package:flutter_instagram/utils/colors.dart';
import 'package:flutter_instagram/utils/utils.dart';
import 'package:flutter_instagram/widgets/square_tile.dart';
import 'package:flutter_instagram/widgets/text_field_input.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../responsive/web_screen_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  bool _isLoading = false;
  final passwordController = TextEditingController();

  void navigateToSignUp() {
    Navigator.push(context,
        MaterialPageRoute(builder: ((context) => const SignupScreen())));
  }

  Future<void> loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: emailController.text, password: passwordController.text);

    setState(() {
      _isLoading = false;
    });

    if (res != "success") {
      // ignore: use_build_context_synchronously
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
              builder: (context) => const ResponsiveLayout(
                  mobileScreenLayout: MobilescreenLayout(),
                  webScreenLayout: WebscreenLayout())));
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                // ignore: deprecated_member_use
                color: Colors.black,
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                "Welcome back, you've been missed!",
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                    fontStyle: FontStyle.italic),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldInput(
                  textEditingController: emailController,
                  hintText: "Enter your Email",
                  textInputType: TextInputType.emailAddress),
              const SizedBox(
                height: 5,
              ),
              TextFieldInput(
                textEditingController: passwordController,
                hintText: "Password",
                textInputType: TextInputType.visiblePassword,
                isPass: true,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Forgot password?",
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: loginUser,
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                        const Size(325, 50)), // Set width and height
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(5), // Set border radius
                    )),
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 2, 5, 7)), // Button color
                    foregroundColor:
                        MaterialStateProperty.all(Colors.white), // Text color
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: primaryColor,
                        )
                      : const Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
              const SizedBox(
                height: 40,
              ),
              Text(
                "Or continue with",
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SquareTile(imagePath: "assets/google.png"),
                  SizedBox(
                    width: 30,
                  ),
                  SquareTile(imagePath: "assets/apple.png"),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member?",
                    style: TextStyle(
                        color: Colors.grey[700], fontStyle: FontStyle.italic),
                  ),
                  GestureDetector(
                    onTap: navigateToSignUp,
                    child: const Text(
                      "Register Now",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              )
            ],
          ),
        ),
      ),
    );
  }
}
