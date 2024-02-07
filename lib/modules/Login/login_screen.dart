// import 'dart:html';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/homeScreen.dart';
import 'package:e_commerce_app/modules/Login/login_cubit.dart';
import 'package:e_commerce_app/modules/Login/login_states.dart';
import 'package:e_commerce_app/modules/register_screen.dart';
import 'package:e_commerce_app/shared/components/components.dart';
import 'package:e_commerce_app/shared/network/local/cach_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccesState) {
            if (state.loginMode.status!) {
              print(state.loginMode.data!.token);
              CachHelper.saveData(
                      key: 'token', value: state.loginMode.data!.token)
                  .then((value) {
                navigateWithReplacment(context, HomeScreen());
              });
            }
            print(state.loginMode.message);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Form(
                    key: formKey,
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
                          "Login now to browse",
                          style: TextStyle(
                              fontSize: 16,
                              wordSpacing: 0.5,
                              color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultTextField(
                            Controller: emailController,
                            LableText: "Email",
                            Type: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "please enter username";
                              }
                            },
                            prefix: Icons.email_outlined),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultTextField(
                            Controller: passwordController,
                            LableText: "Password",
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).UserLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                                print("object");
                                // navigateTo(context, RegisterScreen());
                              } else {
                                print("object00000");
                              }
                            },
                            Type: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return "Enter password ";
                              }
                            },
                            prefix: Icons.lock_outlined,
                            suffix: LoginCubit.get(context).suffix,
                            suffixPressed: () {
                              print("change");
                              LoginCubit.get(context)
                                  .changePasswordVisability();
                            },
                            isPassword:
                                LoginCubit.get(context).ispasswordShown),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                            condition: true,
                            builder: (context) => defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      LoginCubit.get(context).UserLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                      print("object");
                                      // navigateTo(context, RegisterScreen());
                                    } else {
                                      print("object00000");
                                    }
                                  },
                                  text: "Login",
                                  isUpperCase: true,
                                ),
                            fallback: (context) => const Center(
                                  child: CircularProgressIndicator(),
                                )),
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
            ),
          );
        },
      ),
    );
  }
}
