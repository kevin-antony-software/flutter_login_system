import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";

class NewUser extends StatefulWidget {
  const NewUser({Key? key}) : super(key: key);

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final reconfirmpasswordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    reconfirmpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register New User"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: AutofillHints.email,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              obscureText: true,
              controller: passwordController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              obscureText: true,
              controller: reconfirmpasswordController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: "Confirm Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
              onPressed: () {
                if (checkPassword()) {
                  createUser();
                  Navigator.pushNamed(context, '/');
                } else {
                  _wrongPassword(context);
                  passwordController.text = "";
                  reconfirmpasswordController.text = "";
                }
              },
              icon: Icon(
                Icons.person,
                size: 32,
              ),
              label: Text(
                "Register",
                style: TextStyle(fontSize: 24),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text("Already Registered? Sign in"),
            ),
          ],
        ),
      ),
    );
  }

  bool checkPassword() {
    if (passwordController.text.trim() ==
        reconfirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> createUser() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  Future<void> _wrongPassword(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Passwords did not match'),
          content: const Text('Passwords does not match'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
