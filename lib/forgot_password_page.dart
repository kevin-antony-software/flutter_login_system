import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassWordPage extends StatefulWidget {
  const ForgotPassWordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPassWordPage> createState() => _ForgotPassWordPageState();
}

class _ForgotPassWordPageState extends State<ForgotPassWordPage> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test11"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Reset Password for User",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
              ),
              TextField(
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
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                ),
                onPressed: () async {
                  passwordReset();
                  Navigator.pushNamed(context, '/login');
                },
                icon: Icon(
                  Icons.lock_open_outlined,
                  size: 32,
                ),
                label: Text(
                  "Reset Password",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content:
                  Text("Password Reset Email Link sent, Please check Email."),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }
}
