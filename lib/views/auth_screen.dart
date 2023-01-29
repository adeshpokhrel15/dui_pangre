import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:two_wheelers/constant/app_constant.dart';

import '../providers/login_provider.dart';

class loginScreen extends StatefulWidget {
  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final nameController = TextEditingController();

  final mailController = TextEditingController();

  final passwordController = TextEditingController();

  final contactController = TextEditingController();

  final _form = GlobalKey<FormState>();

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: Consumer(builder: (context, ref, child) {
        final isLogin = ref.watch(loginProvider);

        return Form(
            key: _form,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.network(
                        AppConstant.image2,
                        height: 260,
                        width: double.infinity,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Center(
                        child: Text(
                          'Welcome to 2 Pangre! ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      const Center(
                        child: Text(
                          'Share your vehicle',
                          style: TextStyle(color: Colors.grey, fontSize: 17),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (isLogin == false)
                        TextFormField(
                          controller: nameController,
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
                        TextFormField(
                          controller: contactController,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              hintText: 'Contact'),
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: MaterialButton(
                          onPressed: () {},
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
                                // ref.read(loginProvider.notifier).toggle();
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
              ),
            ));
      })),
    );
  }
}
