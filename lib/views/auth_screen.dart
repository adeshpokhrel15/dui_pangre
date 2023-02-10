import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import '../providers/image_provider.dart';
import '../providers/login_provider.dart';

class LoginScreen extends StatelessWidget {
  final usernameController = TextEditingController();
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final _form = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer(builder: (context, ref, child) {
      final isLogin = ref.watch(loginProvider);
      final dbimage = ref.watch(imageProvider);

      return SingleChildScrollView(
        child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SizedBox(
                  height: isLogin ? 390 : 560,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        isLogin ? 'Login Form' : 'SignUp Form',
                        style: const TextStyle(
                            fontSize: 20,
                            letterSpacing: 2,
                            color: Colors.blueGrey),
                      ),
                      if (!isLogin)
                        TextFormField(
                          controller: usernameController,
                          textCapitalization: TextCapitalization.words,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'username is required';
                            }
                            if (val.length > 30) {
                              return 'maximum user length is 30';
                            }
                            return null;
                          },
                          decoration:
                              const InputDecoration(hintText: 'username'),
                        ),
                      if (!isLogin)
                        InkWell(
                          onTap: () {
                            ref.read(imageProvider.notifier).getImage();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: SizedBox(
                                height: 140,
                                child: dbimage.image == null
                                    ? const Center(
                                        child: Text("please select an image"),
                                      )
                                    : Image.file(
                                        File(dbimage.image!.path),
                                        fit: BoxFit.cover,
                                      )),
                          ),
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (!isLogin)
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: addressController,
                          decoration: const InputDecoration(hintText: 'email'),
                        ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'email is required';
                          }
                          if (!val.contains('@')) {
                            return 'please provide valid email address';
                          }
                          return null;
                        },
                        controller: mailController,
                        decoration: const InputDecoration(hintText: 'email'),
                      ),
                      TextFormField(
                        controller: passwordController,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'password is required';
                          }
                          if (val.length > 20) {
                            return 'maximum password length is 20';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: const InputDecoration(hintText: 'password'),
                      ),
                      SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () async {
                            _form.currentState!.save();

                            FocusScope.of(context).unfocus();
                            if (_form.currentState!.validate()) {
                              if (isLogin) {
                                ref.read(logSignProvider).logIn(
                                      email: mailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    );
                              } else {
                                if (dbimage.image == null) {
                                  print('please select an image');
                                }
                                ref.read(logSignProvider).signUp(
                                      userName: usernameController.text.trim(),
                                      email: mailController.text.trim(),
                                      password: passwordController.text.trim(),
                                      image: dbimage.image!,
                                      address: addressController.text.trim(),
                                    );
                              }

                              // if (response != 'success') {
                              //   ref.read(loginProvider.notifier).toggle();
                              //   Get.showSnackbar(GetSnackBar(
                              //     duration: Duration(seconds: 1),
                              //     title: 'some error occurred',
                              //     message: response,
                              //   ));
                              // }
                              // } else {

                              //   if (response != 'success') {
                              //     ref.read(loginProvider.notifier).toggle();
                              //     Get.showSnackbar(GetSnackBar(
                              //       duration: Duration(seconds: 1),
                              //       title: 'some error occurred',
                              //       message: response,
                              //     ));
                              //   }
                              // }
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Submit',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(isLogin
                              ? 'Don\'t have account ?'
                              : 'Already have an account ?'),
                          TextButton(
                              onPressed: () {
                                ref.read(loginProvider.notifier).toggle();
                              },
                              child: Text(isLogin ? 'SignUp' : 'Login'))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )),
      );
    }));
  }
}
