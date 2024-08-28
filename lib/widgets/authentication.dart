
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_recipe_app/api/firebase_auth_service.dart';
import 'package:food_recipe_app/widgets/auth_form_field.dart';


class Authentication extends ConsumerStatefulWidget {

  const Authentication({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthenticationState();
}

class _AuthenticationState extends ConsumerState<Authentication> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _reEnterPasswordController;

  final _formKey = GlobalKey<FormState>();

  bool isLogin = true;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _reEnterPasswordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _reEnterPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
       Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isLogin
                ? Center(
              child: RichText(
                  text: TextSpan(text: 'Need an account?  ', children: [
                    TextSpan(
                        text: 'Sign Up',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.yellowAccent),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              isLogin = false;
                            });
                          })
                  ])),
            )
                : Center(
              child: RichText(
                  text: TextSpan(text: 'Returning User?  ', children: [
                    TextSpan(
                        text: 'Sign In',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.yellowAccent),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              isLogin = true;
                            });
                          })
                  ])),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  isLogin
                      ? const SizedBox.shrink()
                      : AuthFormField(
                    textEditingController: _nameController,
                    hintText: 'Username',
                    validate: (_) {
                      return null;
                    },
                  ),
                  AuthFormField(
                      textEditingController: _emailController,
                      hintText: 'Email',
                      validate: (_) {
                        if (_emailController.text.isEmpty)
                          return 'Empty field';
                        return null;
                      }),
                  AuthFormField(
                      textEditingController: _passwordController,
                      hintText: 'Password',
                      isObscure: true,
                      validate: (value) {
                        if (_passwordController.text.isEmpty) {
                          return 'Empty field';
                        }
                        return null;
                      }),
                  isLogin
                      ? const SizedBox.shrink()
                      : AuthFormField(
                      textEditingController: _reEnterPasswordController,
                      hintText: 'Re-enter Password',
                      isObscure: true,
                      validate: (value) {
                        if (_reEnterPasswordController.text.isEmpty)
                          return 'Empty field';
                        if (_passwordController.text !=
                            _reEnterPasswordController.text) {
                          return 'Password not match';
                        }
                        return null;
                      }),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink, fixedSize: const Size(200, 20)),
              onPressed: () {
                FocusScope.of(context).unfocus();

                if(_formKey.currentState!.validate()) {
                  isLogin
                    ? ref.read(firebaseAuthServiceProvider).signIn(
                    email: _emailController.text,
                    password: _passwordController.text)
                    : ref.read(firebaseAuthServiceProvider).signUp(
                    email: _emailController.text,
                    password: _passwordController.text,
                    userName: _nameController.text);
                }
              },
              child: Text(
                isLogin ? 'Login' : 'Sign Up',
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          ],

        ),
       );

  }

  // void _signUpAccount() async {
  //   try {
  //     final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //         email: _emailController.text, password: _passwordController.text);
  //     user.user?.updateProfile(displayName: _nameController.text);
  //     print(FirebaseAuth.instance.currentUser);
  //     FirestoreService().addUser(email: _emailController.text, name: _nameController.text.isEmpty ? 'User' : _nameController.text);
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('Sign Up successfully.')));
  //     Navigator.of(context).pushReplacement(MaterialPageRoute(
  //       builder: (context) => HomePage(),
  //     ));
  //   } catch (e) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text(e.toString())));
  //   }
  // }
}
