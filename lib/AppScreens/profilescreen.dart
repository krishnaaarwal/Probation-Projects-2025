import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/AuthecationScreens/deleteaccount.dart';
import 'package:quiz_app/AuthecationScreens/updatepass.dart';
import 'package:quiz_app/AuthecationScreens/updateusername.dart';
import 'package:quiz_app/MoreScreens/about_screen.dart';
import 'package:quiz_app/firebase_services/auth_services.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  void logout() async {
    try {
      await authService.value.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900]!,
      appBar: AppBar(
        backgroundColor: Colors.grey[900]!,
        title: Text(
          "My Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontStyle: FontStyle.italic,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: Colors.grey[800],
                shadowColor: Colors.black54,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.deepPurple,
                        backgroundImage: AssetImage('assets/pekka.jpg'),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'P.E.K.K.A',
                        style: TextStyle(
                          color: Colors.amberAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'butterfly@gmail.com',
                        style: TextStyle(color: Colors.grey[400], fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                color: Colors.grey[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.withOpacity(0.3),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Text(
                        "Settings",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    _buildSettingsItem(
                      "Update username",
                      Icons.person_outline,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateUsername(),
                          ),
                        );
                      },
                    ),
                    _buildDivider(),
                    _buildSettingsItem(
                      "Change password",
                      Icons.lock_outline,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdatePassword(),
                          ),
                        );
                      },
                    ),
                    _buildDivider(),
                    _buildSettingsItem(
                      "Delete my account",
                      Icons.delete_outline,
                      textColor: Colors.red[300]!,
                      iconColor: Colors.red[300]!,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeleteAccount(),
                          ),
                        );
                      },
                    ),
                    _buildDivider(),
                    _buildSettingsItem(
                      "About this app",
                      Icons.info_outline,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => AboutAppScreen()),
                        );
                      },
                    ),
                    _buildDivider(),
                    _buildSettingsItem(
                      "Logout",
                      Icons.logout,
                      textColor: Colors.red,
                      iconColor: Colors.red,
                      onTap: () {
                        // logout();
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem(
    String title,
    IconData icon, {
    Color textColor = Colors.white,
    Color iconColor = Colors.white,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor, size: 24),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: textColor,
        size: 16,
      ),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      color: Colors.grey[700],
      indent: 16,
      endIndent: 16,
    );
  }
}
