import 'package:barbershop/pages/login.dart';
import 'package:flutter/material.dart';

class LoginBtnOfStartingPage extends StatelessWidget {
  const LoginBtnOfStartingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        },
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width / 2,
          decoration: const BoxDecoration(
            color: Color(0xFFD4AF37),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
          ),
          child: const Center(
            child: Text(
              "Login",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
