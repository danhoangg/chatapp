import 'dart:collection';

import 'package:chat_app/components/my_login_button.dart';
import 'package:chat_app/components/my_text_field.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  final void Function()? onPressed;
  const SignupPage({super.key, required this.onPressed});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords don't match"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.registerWithEmailAndPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title text
                const Text('Signup', style: TextStyle(fontSize: 36)),

                const SizedBox(height: 40),

                // Input fields
                MyTextField(
                  controller: emailController,
                  hintText: "Enter your email",
                  labelText: "Email",
                  obscureText: false,
                ),

                MyTextField(
                  controller: passwordController,
                  hintText: "Enter your password",
                  labelText: "Password",
                  obscureText: true,
                ),

                MyTextField(
                  controller: confirmPasswordController,
                  hintText: "Re-enter your password",
                  labelText: "Re-enter Password",
                  obscureText: true,
                ),

                // Login button
                LoginButton(
                  text: "Sign Up",
                  icon: Icons.login,
                  emailController: emailController,
                  passwordController: passwordController,
                  onPressed: signUp,
                ),

                Row(
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        widget.onPressed!();
                      },
                      child: const Text(
                        'Log in!',
                        style: TextStyle(color: Colors.purple),
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
