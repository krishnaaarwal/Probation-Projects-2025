import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quiz_app/AppScreens/leaderboard.dart';
import 'package:quiz_app/AppScreens/profilescreen.dart';
import 'package:quiz_app/AppScreens/quizscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  List<Widget> pages = [HomeTab(), LeaderboardScreen(), MyProfile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: IndexedStack(index: _currentIndex, children: pages),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.amberAccent,
        unselectedItemColor: Colors.grey[300],
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 100,
        centerTitle: true,
        elevation: 20,
        title: ListTile(
          title: Text(
            'Quiz Royale',
            style: TextStyle(
              color: Colors.amberAccent,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          subtitle: Text(
            'Test your brain. Conquer the leaderboard.',
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
          trailing: Image.asset('assets/qr1.png', height: 72, width: 72),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuizScreen()),
                    );
                  },
                  elevation: 10,
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.start),
                    title: Text("Play Game"),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LeaderboardScreen(),
                      ),
                    );
                  },
                  elevation: 10,
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.leaderboard),
                    title: Text("Leaderboard"),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: MaterialButton(
                  onPressed: () {},
                  elevation: 10,
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Options"),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: MaterialButton(
                  onPressed: () {
                    exit(0);
                  },
                  elevation: 10,
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text("Exit"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
