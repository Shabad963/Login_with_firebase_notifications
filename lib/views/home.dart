import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
 setState(() {
        isLoaded = true;
      });  }


  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text(user.email!),
        backgroundColor: Colors.teal,
        actions: [
          TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Visibility(
        visible: isLoaded,
        // ignore: sort_child_properties_last
        child: Container(),
        replacement: Center(
          child: CircularProgressIndicator(),
        ),
      ),

    );
  }


}
