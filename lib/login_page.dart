import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test11"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            TextField(
              obscureText: true,
              controller: passwordController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: AutofillHints.password,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/forgot');
                  },
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
              onPressed: () async {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim());
                Navigator.pushNamed(context, '/');
              },
              icon: Icon(
                Icons.lock_open_outlined,
                size: 32,
              ),
              label: Text(
                "Login",
                style: TextStyle(fontSize: 24),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text("New User? Create Account"),
            ),
            SizedBox(
              height: 20,
            ),
            //
            SignInButton(
              Buttons.Google,
              onPressed: () {
                final user = signInWithGoogle();
                Navigator.pushNamed(context, '/');
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    print("google sign in method");
    final googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
