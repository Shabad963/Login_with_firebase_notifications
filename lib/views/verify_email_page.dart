import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_sample/utils/utils.dart';
import 'package:firebase_sample/views/home.dart';
import 'package:flutter/material.dart';

class VerifyEmailPAge extends StatefulWidget {
  const VerifyEmailPAge({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPAge> createState() => _VerifyEmailPAgeState();
}

class _VerifyEmailPAgeState extends State<VerifyEmailPAge> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(Duration(seconds: 3), (_) => checkEmailVerified());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? MyHomePage(title: 'home',)
      : Scaffold(
          appBar: AppBar(
            title: Text('Verify Email'),
            backgroundColor: lightBlueAccent,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('A verification email has been sent to your email'),
              SizedBox(height: 25),
              ElevatedButton.icon(
                  style: TextButton.styleFrom(
                      minimumSize: Size.fromHeight(40),
                      backgroundColor: lightBlueAccent),
                  onPressed: () =>
                      canResendEmail ? sendVerificationEmail() : null,
                  icon: Icon(Icons.email),
                  label: Text('Resend Email')),
              SizedBox(height: 15),
              TextButton(
                onPressed: () => FirebaseAuth.instance.signOut(),
                child: Text('Go to Login page'),
              )
            ]),
          ),
        );
}
