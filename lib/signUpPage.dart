import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quickie/loginPage.dart';
import 'firebase_options.dart';
import 'dart:developer';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Join the family'),
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        offset: const Offset(1, 1),
                        color: Colors.grey.withOpacity(0.0),
                      )
                    ]),
                child: TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                      hintText: "Username",
                      prefixIcon:
                          const Icon(Icons.person_outline, color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                          // when clicked
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Colors.purpleAccent,
                            width: 1.0,
                          )),
                      enabledBorder: const OutlineInputBorder(
                          //default when reloaded
                          borderSide: BorderSide(
                        color: Colors.grey,
                      )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                ),
              ),
              const SizedBox(height: 15.0),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        offset: const Offset(1, 1),
                        color: Colors.grey.withOpacity(0.0),
                      )
                    ]),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      hintText: "Enter Your Email",
                      prefixIcon:
                          const Icon(Icons.person_outline, color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                          // when clicked
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Colors.purpleAccent,
                            width: 1.0,
                          )),
                      enabledBorder: const OutlineInputBorder(
                          //default when reloaded
                          borderSide: BorderSide(
                        color: Colors.grey,
                      )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [AutofillHints.email],
                ),
              ),
              const SizedBox(height: 15.0),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        offset: const Offset(1, 1),
                        color: Colors.grey.withOpacity(0.0),
                      )
                    ]),
                child: TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      hintText: "Enter your Password",
                      prefixIcon: const Icon(Icons.password_outlined,
                          color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                          // when clicked
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Colors.purpleAccent,
                            width: 1.0,
                          )),
                      enabledBorder: const OutlineInputBorder(
                          //default when reloaded
                          borderSide: BorderSide(
                        color: Colors.grey,
                      )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  keyboardType: TextInputType.visiblePassword,
                  autofillHints: const [AutofillHints.password],
                ),
              ),
              const SizedBox(height: 15.0),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 10,
                        offset: const Offset(1, 1),
                        color: Colors.grey.withOpacity(0.0),
                      )
                    ]),
                child: TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                      hintText: "Confirm your password",
                      prefixIcon: const Icon(Icons.password_outlined,
                          color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                          // when clicked
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Colors.purpleAccent,
                            width: 1.0,
                          )),
                      enabledBorder: const OutlineInputBorder(
                          //default when reloaded
                          borderSide: BorderSide(
                        color: Colors.grey,
                      )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5))),
                  keyboardType: TextInputType.visiblePassword,
                  autofillHints: const [AutofillHints.password],
                ),
              ),
              const SizedBox(height: 15.0),
              ElevatedButton(
                onPressed: () async {

                  if (await _signup()){
                    log('The function works');
                    if (mounted){
                      Navigator.pushReplacementNamed(this.context, '/login');

                    }

                  }

                },
                child: const Text('Signup'),
              ),
              ElevatedButton(
                onPressed: () {
                  UserCredential user = signInWithGoogle() as UserCredential;
                  _saveGoogleUser(user);
                },
                child: const Text('Signup with Google'),
              ),
            ],
          ),
        ),
    );
  }

  bool validateInput(username, password) {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Check if username and password are not empty
    // Add any other validation criteria here (length, format, etc.)
    if (username.isEmpty || password.isEmpty) {
      print("Username and password cannot be empty");
      return false;
    }


    // Add more validations as needed


    return true;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  Future<bool> _signup() async {
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );

    String username = _usernameController.text;
    if (validateInput(_usernameController, _passwordController)){

      UserCredential creds =
      await firebase.FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      User? user = creds.user;

      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'firstName': username,
        'lastName': 'lastName',
        'email': _emailController.text,
        'password': _passwordController.text
      });



      // User? usernames = FirebaseAuth.instance.currentUser;
      // usernames?.sendEmailVerification();

      return true;
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User is empty')),
      );
      return false;
    }


    // ignore: unnecessary_null_comparison
    // if (user != null) {
    //   await user.updateDisplayName(username);
    //   return true;
    // } else {
    //   return false;
    // }

    // Here you can implement your login logic
    // For simplicity, let's just print the username and password
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
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

  Future<void> _saveGoogleUser(UserCredential user) async {
    final userCredential = await signInWithGoogle();
    if (userCredential.user != null) {
      // User is signed in
      print('Logged in already');
    } else {
      // User is not signed in
      await firebase.FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userCredential.user!.email.toString(),
        password: userCredential.toString(),
      );
    }
  }

}
