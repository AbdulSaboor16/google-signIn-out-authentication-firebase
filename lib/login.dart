import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile/logoutscreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("login with Google"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                googleLogin() async {
                  print("googleLogin method Called");
                  GoogleSignIn _googleSignIn = GoogleSignIn();
                  try {
                    var reslut = await _googleSignIn.signIn();
                    if (reslut == null) {
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LogoutPage()),
                    );
                    final userData = await reslut.authentication;
                    final credential = GoogleAuthProvider.credential(
                        accessToken: userData.accessToken,
                        idToken: userData.idToken);
                    var finalResult = await FirebaseAuth.instance
                        .signInWithCredential(credential);
                    print("Result $reslut");
                    // print(reslut.displayName);
                    // print(reslut.email);
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text("${reslut.displayName}"),
                              content: Text("${reslut.email}"),
                            ));
                    print(reslut.photoUrl);
                  } catch (error) {
                    print(error);
                  }
                }

                googleLogin();
              },
              child: Text("login with Google"),
            ),
          ],
        ),
      ),
    );
  }
}
