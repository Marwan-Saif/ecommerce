// import 'dart:html';

import 'package:e_commerce_app/modules/register_screen.dart';
import 'package:e_commerce_app/shared/components/components.dart';
import 'package:flutter/material.dart';

class LgoinScreen extends StatelessWidget {
  const LgoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "LOGIN",
                  style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                      wordSpacing: 0.25),
                ),
                const Text(
                  "login now to browse",
                  style: TextStyle(
                      fontSize: 16, wordSpacing: 0.5, color: Colors.grey),
                ),
                const SizedBox(
                  height: 30,
                ),
                defaultTextField(
                    Controller: emailController,
                    LableText: "Email",
                    Type: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.toString().isEmpty)
                        {return "please enter username";}
                      return null;
                    },
                    prefix: Icons.email_outlined),
                const SizedBox(
                  height: 30,
                ),
                defaultTextField(
                    Controller: passwordController,
                    LableText: "Password",
                    Type: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.toString().isEmpty) return "Enter password ";
                      return null;
                    },
                    prefix: Icons.lock_outlined,
                    suffix: Icons.visibility_outlined),
                const SizedBox(
                  height: 30,
                ),
                defaultButton(
                  function: () {},
                  text: "Login",
                  isUpperCase: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Dont't have an account ? "),
                    defaultTextButton(
                        function: () {
                          navigateTo(context, const RegisterScreen());
                        },
                        text: "Register")
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
