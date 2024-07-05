// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_instagram/resources/auth_methods.dart';
import 'package:flutter_instagram/responsive/mobile_screen_layout.dart';
import 'package:flutter_instagram/responsive/responsive_layout.dart';
import 'package:flutter_instagram/responsive/web_screen_layout.dart';
import 'package:flutter_instagram/screens/login_screen.dart';
import 'package:flutter_instagram/utils/colors.dart';
import 'package:flutter_instagram/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_instagram/widgets/square_tile.dart';
import 'package:flutter_instagram/widgets/text_field_input.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _bioController = TextEditingController();
  final _passwordController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  void navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => const LoginScreen())));
  }


  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  Future<void> selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image);
    // ignore: avo
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                // ignore: deprecated_member_use
                color: Colors.black,
              ),
              const SizedBox(
                height: 20,
              ),
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 48,
                          backgroundImage: MemoryImage(_image!),
                        )
                      : const CircleAvatar(
                          radius: 48,
                          backgroundImage: NetworkImage(
                              "https://images.unsplash.com/photo-1543332164-6e82f355badc?auto=format&fit=crop&q=80&w=870&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                        ),
                  Positioned(
                      bottom: -7,
                      left: 55,
                      child: IconButton(
                          onPressed: () {
                            selectImage();
                          },
                          icon: const Icon(Icons.add_a_photo)))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Welcome, Let's get started!",
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                    fontStyle: FontStyle.italic),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldInput(
                  textEditingController: _usernameController,
                  hintText: "Enter unique Username",
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 5,
              ),
              TextFieldInput(
                  textEditingController: _emailController,
                  hintText: "Enter your Email",
                  textInputType: TextInputType.emailAddress),
              const SizedBox(
                height: 5,
              ),
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: "Password",
                textInputType: TextInputType.visiblePassword,
                isPass: true,
              ),
              const SizedBox(
                height: 5,
              ),
              TextFieldInput(
                  textEditingController: _bioController,
                  hintText: "Enter your Bio",
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: signUpUser,
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
                  child: _isLoading? const Center(child: CircularProgressIndicator(color: primaryColor, strokeWidth: 5,))
                  : const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
                  )),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Or continue with",
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(
                height: 10,
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
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already a member?",
                    style: TextStyle(
                        color: Colors.grey[700], fontStyle: FontStyle.italic),
                  ),
                  GestureDetector(
                    onTap: navigateToSignUp,
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8,)
            ],
          ),
        ),
      ),
    );
  }
}
