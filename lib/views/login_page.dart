import 'dart:ui' as prefix;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample/utils/utils.dart';
import 'package:firebase_sample/views/forgot_password_page.dart';
import 'package:firebase_sample/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const LoginWidget({Key? key, required this.onClickedSignUp})
      : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
                "https://icons.iconarchive.com/icons/papirus-team/papirus-apps/128/system-users-icon.png"),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: 'Email', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                  labelText: 'Password', border: OutlineInputBorder()),
              obscureText: true,
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton.icon(
              onPressed: () {
                signIn();
              },
              label: Text(
                'Log in',
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                  minimumSize: Size.fromHeight(40),
                  backgroundColor: Colors.teal),
              icon: Icon(Icons.lock),
            ),
            SizedBox(
              height: 24,
            ),
            GestureDetector(
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.teal,
                    fontSize: 20),
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ForgotPassWordPage(),
              )),
            ),
            SizedBox(
              height: 40,
            ),
            RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.black),
                    text: 'No account?   ',
                    children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onClickedSignUp,
                      text: 'SignUp',
                      style: TextStyle(color: Colors.teal))
                ]))
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
