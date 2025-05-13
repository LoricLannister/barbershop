import 'package:barbershop/widgets/background_starting_page.dart';
import 'package:barbershop/widgets/login_btn_starting_page.dart';
import 'package:barbershop/widgets/register_btn_starting_page.dart';
import 'package:flutter/material.dart';

class StartingPage extends StatefulWidget {
  const StartingPage({super.key});

  @override
  State<StartingPage> createState() => _StartingPageState();
}

class _StartingPageState extends State<StartingPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundStartingPage(),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5,
            left: 30,
            child: const Text(
              "Welcome Back!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.6,
            left: 28,
            child: const Text(
              "Locate the nearest\nbarbershop to you,\nlet's go !!!!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
          ),
          const RegisterBtnOfStartingPage(),
          const LoginBtnOfStartingPage(),
        ],
      ),
    );
  }
}
