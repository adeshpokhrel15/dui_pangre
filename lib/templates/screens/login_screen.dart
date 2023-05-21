
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:two_wheelers/templates/screens/status_screen.dart';

import '../../providers/auth_provider.dart';
import '../../providers/image_provider.dart';
import '../../providers/login_provider.dart';
import '../widgets/buttom_navigation_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final _form = GlobalKey<FormState>();

  bool _isObscure = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: Consumer(builder: (context, ref, child) {
        final isLogin = ref.watch(loginProvider);
        final dbimage1 = ref.watch(imageProvider);
        final dbimage2 = ref.watch(imageProvider1);

        return Form(
            key: _form,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    const Center(
                      child: Text(
                        'Welcome to Dui Pangre! ',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    const Center(
                      child: Text(
                        'Rent a ride, explore the city',
                        style: TextStyle(color: Colors.grey, fontSize: 17),
                      ),
                    ),
                    Center(
                        child: Lottie.network(
                            'https://assets1.lottiefiles.com/packages/lf20_vuubgscl.json')),
                    if (isLogin == false)
                      TextFormField(
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'This field is required';
                          }

                          return null;
                        },
                        controller: usernameController,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            hintText: 'Username'),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'This field is required';
                        }

                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      controller: mailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          hintText: 'Email'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'This field is required';
                        }

                        return null;
                      },
                      obscureText: _isObscure,
                      controller: passwordController,
                      //obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              }),
                          hintText: 'Password'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (isLogin == false)
                      Container(
                        height: 140,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  ref.read(imageProvider.notifier).getImage();
                                },
                                child: Container(
                                  height: 140,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: dbimage1.image == null
                                      ? const Center(
                                          child: Text(
                                            "Please select Profile pic",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 70, 68, 68),
                                              fontSize: 16,
                                            ),
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.file(
                                            File(dbimage1.image!.path),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (isLogin == false)
                      Container(
                        height: 140,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  ref.read(imageProvider1.notifier).getImage();
                                },
                                child: Container(
                                  height: 140,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: dbimage2.image == null
                                      ? const Center(
                                          child: Text(
                                            "Please select Licence pic",
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 70, 68, 68),
                                              fontSize: 16,
                                            ),
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.file(
                                            File(dbimage2.image!.path),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: MaterialButton(
                        onPressed: () async {
                          _form.currentState!.save();

                          FocusScope.of(context).unfocus();
                          if (_form.currentState!.validate()) {
                            if (isLogin) {
                              String value = await ref
                                  .read(logSignProvider)
                                  .logIn(
                                    email: mailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  );
                              if (value == 'success') {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            const BottomNavigationBarWidgets())));
                              }
                            } else {
                              if (dbimage1.image == null) {}
                              String value = await ref
                                  .read(logSignProvider)
                                  .signUp(
                                    userName: usernameController.text.trim(),
                                    email: mailController.text.trim(),
                                    password: passwordController.text.trim(),
                                    image1: dbimage1.image!,
                                    image2: dbimage2.image!,
                                    address: addressController.text.trim(),
                                  );

                              if (value == 'success') {
                                ref.read(loginProvider.notifier).toggle();
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            const StatusScreen())));
                              }
                            }
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22.0)),
                        elevation: 5.0,
                        color: const Color(0xFF00a2e8),
                        textColor: Colors.black,
                        child: const Text('Login'),
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password',
                          style: TextStyle(color: Colors.red),
                        )),
                    Row(
                      children: [
                        Text(isLogin
                            ? 'Don\'t have account ?'
                            : 'Already have an account ?'),
                        TextButton(
                            onPressed: () {
                              ref.read(loginProvider.notifier).toggle();
                            },
                            child: Text(
                              isLogin ? 'Register' : 'Login',
                              style: const TextStyle(color: Colors.red),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ));
      })),
    );
  }
}
