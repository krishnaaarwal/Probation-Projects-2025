import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/AuthecationScreens/registerpage.dart';
import 'package:quiz_app/AuthecationScreens/resetpassword.dart';
import 'package:quiz_app/firebase_services/auth_services.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => LoginPageState();
}

class LoginPageState extends State<Loginpage> {
  final TextEditingController _emailc = TextEditingController();
  final TextEditingController _passwordc = TextEditingController();
  String errormessage = '';

  @override
  void dispose() {
    _emailc.dispose();
    _passwordc.dispose();
    super.dispose();
  }

  void login() async {
    try {
      await authService.value.signIn(
        email: _emailc.text,
        password: _passwordc.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errormessage = e.message ?? 'This is an error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/qr1.png",
              width: 300,
              height: 200,
              isAntiAlias: true,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: formWidget(
                        "Email",
                        _emailc,
                        Icons.email,
                        TextInputType.emailAddress,
                      ),
                    ),
                    SizedBox(height: 30),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: formWidget(
                        "Password",
                        _passwordc,
                        Icons.password_outlined,
                        TextInputType.visiblePassword,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      errormessage,
                      style: TextStyle(color: Colors.red, fontSize: 10),
                    ),
                    SizedBox(height: 30),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: MaterialButton(
                        onPressed: () {
                          login();
                        },
                        textColor: Colors.black,
                        color: Colors.amber[50],
                        child: Text("LogIn"),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        ResetPassword();
                      },
                      child: Text(
                        "Forgotten Password?",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 15),

                    Divider(
                      height: 6,
                      thickness: 4,
                      color: Colors.orangeAccent[200],
                    ),

                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterScreen(),
                            ),
                          );
                        },
                        textColor: Colors.white,
                        color: Colors.amberAccent,
                        child: Text("Create a new account"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget formWidget(
    String name,
    TextEditingController controller,
    IconData icon,
    TextInputType type,
  ) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: name,
        hintText: "Enter $name",
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
      ),
      onChanged: (String value) {},
      validator: (value) {
        return value!.isEmpty ? " Enter your $name" : null;
      },
    );
  }
}
