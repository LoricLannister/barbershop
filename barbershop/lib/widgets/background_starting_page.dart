import 'package:flutter/material.dart';

class BackgroundStartingPage extends StatefulWidget {
  const BackgroundStartingPage({super.key});

  @override
  State<BackgroundStartingPage> createState() => _BackgroundStartingPageState();
}

class _BackgroundStartingPageState extends State<BackgroundStartingPage> {

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/starting.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.9),
                ],
              ),
            ),
          ),
        ],
    );
  }
}
