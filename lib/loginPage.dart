import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      home: Scaffold(

        appBar: AppBar(
          title: const Text('Login Page'),
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
                    boxShadow: [BoxShadow(
                      blurRadius: 10,
                      offset: const Offset(1, 1),
                      color: Colors.grey.withOpacity(0.0),
                    )]
                ),
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                      hintText: "Email or Username",
                      prefixIcon: const Icon(Icons.person_outline, color: Colors.grey),
                      focusedBorder: OutlineInputBorder( // when clicked
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Colors.purpleAccent,
                            width: 1.0,
                          )
                      ),
                      enabledBorder: const OutlineInputBorder( //default when reloaded
                          borderSide: BorderSide(
                            color: Colors.grey,
                          )
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)
                      )
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [BoxShadow(
                      blurRadius: 10,
                      offset: const Offset(1, 1),
                      color: Colors.grey.withOpacity(0.0),
                    )]
                ),
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: const Icon(Icons.password_outlined, color: Colors.grey),
                      focusedBorder: OutlineInputBorder( // when clicked
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Colors.purpleAccent,
                            width: 1.0,
                          )
                      ),
                      enabledBorder: const OutlineInputBorder( //default when reloaded
                          borderSide: BorderSide(
                            color: Colors.grey,
                          )
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)
                      )
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              ElevatedButton(
                onPressed: () async{
                  if (await loginWithEmailPassword(_usernameController.text, _passwordController.text)){
                    if (mounted){
                      Navigator.pushReplacementNamed(this.context, '/addCardDetails');
                    }
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> loginWithEmailPassword(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      print(e); // Ideally, use a more user-friendly error handling
      return false;
    }
  }


  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Here you can implement your login logic
    // For simplicity, let's just print the username and password
  }
}
