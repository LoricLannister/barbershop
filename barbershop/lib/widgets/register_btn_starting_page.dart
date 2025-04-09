import 'package:barbershop/pages/register.dart';
import 'package:flutter/material.dart';

class RegisterBtnOfStartingPage extends StatelessWidget {
  const RegisterBtnOfStartingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      child: SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width / 2,
        child: Center(
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterPage()));
            },
            child: const Text(
              "Register",
              style: TextStyle(
                color: Colors.white,
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
