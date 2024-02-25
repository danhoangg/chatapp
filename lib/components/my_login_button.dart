import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final void Function()? onPressed;
  const LoginButton({
    super.key,
    required this.text,
    required this.icon,
    required this.emailController,
    required this.passwordController,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
        ),
        onPressed: () {
          onPressed!();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                )),
            const SizedBox(width: 8),
            Icon(icon, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
