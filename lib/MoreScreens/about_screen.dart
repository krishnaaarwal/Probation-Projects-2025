import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About This App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/qr1.png', height: 80, width: 80),
              const SizedBox(height: 20),

              const Text(
                'Quiz Royale',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              const Text(
                'Quiz × Clash Royale',
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Made with ❤️ ', style: TextStyle(fontSize: 16)),
                  Icon(Icons.favorite, color: Colors.red, size: 20),
                  Text(' by Krishna Agarwal', style: TextStyle(fontSize: 16)),
                ],
              ),

              const SizedBox(height: 40),

              const Text(
                'Quiz Royale combines the thrill of quiz battles with the excitement of Clash Royale-inspired gameplay. '
                'Challenge friends, climb the leaderboard, and prove your knowledge reigns supreme!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
