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

class _LoginWidgetState extends State<LoginWidget>
    with TickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  AnimationController? _animationController1;
  Animation<double>? _animation1;
  AnimationController? _animationController2;
  Animation<double>? _animation2;
  AnimationController? _animationController3;
  Animation<double>? _animation3;
  AnimationController? _animationController4;
  Animation<double>? _animation4;

  @override
  void initState() {
    // TODO: implement initState
    _animationController1 =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation1 =
        Tween<double>(begin: -1.0, end: 0.0).animate(_animationController1!);

    _animationController2 =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation2 =
        Tween<double>(begin: -1.0, end: 0.0).animate(_animationController2!);

    _animationController3 =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation3 =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController3!);

    _animationController4 =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation4 =
        Tween<double>(begin: -1.0, end: 0.0).animate(_animationController4!);
    _animationController1!.forward();
    _animationController2!.forward();
    _animationController3!.forward();
    _animationController4!.forward();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _animationController1!.dispose();
    _animationController2!.dispose();
    _animationController3!.dispose();
    _animationController4!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: appBar(title: "LOGIN"),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [  Colors.white,Colors.indigo],
          ),
        ),
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                  animation: _animationController1!,
                  builder: (context, child) {
                    return Transform(
                      transform: Matrix4.translationValues(
                          0.0, _animation1!.value * 200.0, 0.0),
                      child: child,
                    );
                  },
                  child: Text(
                    'Welcome',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 50.0,
                   height: 3,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              AnimatedBuilder(
                animation: _animationController2!,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.translationValues(
                      _animation2!.value * MediaQuery.of(context).size.width,
                      0.0,
                      0.0,
                    ),
                    child: child,
                  );
                },
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      labelText: 'Email', border: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              AnimatedBuilder(
                animation: _animationController3!,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.translationValues(
                      _animation3!.value * MediaQuery.of(context).size.width,
                      0.0,
                      0.0,
                    ),
                    child: child,
                  );
                },
                child: TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      labelText: 'Password', border: OutlineInputBorder()),
                  obscureText: true,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              AnimatedBuilder(
                  animation: _animationController1!,
                  builder: (context, child) {
                    return Transform(
                      transform: Matrix4.translationValues(
                          0.0, _animation1!.value * -200.0, 0.0),
                      child: child,
                    );
                  },
                  child: Column(
                    children: [
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
                            backgroundColor: lightBlueAccent),
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
                              color: lightBlueAccent,
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
                                style: TextStyle(color: lightBlueAccent))
                          ]))
                    ],
                  )),
            ],
          ),
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
