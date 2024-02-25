import 'dart:collection';

import 'package:chat_app/components/my_login_button.dart';
import 'package:chat_app/components/my_text_field.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onPressed;
  const LoginPage({super.key, required this.onPressed});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // login user
  void login() async {
    // get the auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailandPassword(
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
                const Text('Login', style: TextStyle(fontSize: 36)),

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

                // Login button
                LoginButton(
                  text: "Login",
                  icon: Icons.login,
                  emailController: emailController,
                  passwordController: passwordController,
                  onPressed: login,
                ),

                Row(
                  children: [
                    const Text('Don\'t have an account?'),
                    TextButton(
                      onPressed: () {
                        widget.onPressed!();
                      },
                      child: const Text(
                        'Sign Up!',
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
