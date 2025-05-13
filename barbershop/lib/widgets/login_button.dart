import 'package:barbershop/pages/home.dart';
import 'package:barbershop/apiCalls/login.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatefulWidget {
  final GlobalKey<FormState> formLoginKey;
  final String email;
  final String password;
  const LoginButton(
      {super.key,
      required this.formLoginKey,
      required this.email,
      required this.password});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: ElevatedButton(
          onPressed: () async {
            if (widget.formLoginKey.currentState!.validate()) {
              // Login
              final apiResponse = await login(widget.email, widget.password);
              if (apiResponse["cookie"] == null) {
                ScaffoldMessenger.of(widget.formLoginKey.currentContext!)
                    .showSnackBar(const SnackBar(
                        content: Text("Connexion au serveur impossible!")));
              } else if (apiResponse.containsKey("success") &&
                  apiResponse["success"]) {
                Navigator.pushAndRemoveUntil(
                    widget.formLoginKey.currentContext!,
                    MaterialPageRoute(builder: (context) => HomePage(email: widget.email, username: apiResponse["username"], cookie: apiResponse["cookie"], isAdmin: apiResponse["isAdmin"],)),
                    (route) => false);
              } else {
                ScaffoldMessenger.of(widget.formLoginKey.currentContext!)
                    .showSnackBar(
                        SnackBar(content: Text(apiResponse["message"])));
              }
            } else {
              ScaffoldMessenger.of(widget.formLoginKey.currentContext!)
                  .showSnackBar(const SnackBar(
                      content: Text("Please fill all fields ...")));
            }
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(const Color(0xFFD4AF37)),
          ),
          child: const Text(
            "Login",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
