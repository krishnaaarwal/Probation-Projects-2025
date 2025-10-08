import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/firebase_services/auth_services.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => UpdatePasswordState();
}

class UpdatePasswordState extends State<UpdatePassword> {
  final TextEditingController _emailc = TextEditingController();
  final TextEditingController _oldpasswordc = TextEditingController();
  final TextEditingController _newpasswordc = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String errorMessage = '';

  @override
  void dispose() {
    _emailc.dispose();
    _oldpasswordc.dispose();
    _newpasswordc.dispose();
    super.dispose();
  }

  void updatepass() async {
    try {
      await authService.value.resetPasswordFromCurrentPassword(
        email: _emailc.text,
        currentPassword: _oldpasswordc.text,
        newPassword: _newpasswordc.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message ?? 'There is an error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Update Password",
              style: TextStyle(fontSize: 30, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                        controller: _emailc,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email Address",

                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onChanged: (String value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter an email address";
                          }
                          if (!value.contains('@')) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 30),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                        controller: _oldpasswordc,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Old Password",
                          prefixIcon: Icon(Icons.password_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onChanged: (String value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter a password";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                    SizedBox(height: 40),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextFormField(
                        controller: _newpasswordc,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "New Password",
                          prefixIcon: Icon(Icons.password_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onChanged: (String value) {},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter a password";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                    SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: updatepass,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amberAccent,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text("Confirm"),
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
}
