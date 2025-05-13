import 'package:barbershop/apiCalls/register.dart';
import 'package:barbershop/pages/home.dart';
import 'package:flutter/material.dart';

class RegisterButton extends StatefulWidget {
  final GlobalKey<FormState> formRegisterKey;
  final String username;
  final String email;
  final String password;
  const RegisterButton(
      {super.key,
      required this.formRegisterKey,
      required this.username,
      required this.email,
      required this.password});

  @override
  State<RegisterButton> createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<RegisterButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: ElevatedButton(
          onPressed: () async {
            if (widget.formRegisterKey.currentState!.validate()) {
              // Register
              final apiResponse = await register(
                  widget.username, widget.email, widget.password);
              if (apiResponse["cookie"] == null) {
                ScaffoldMessenger.of(widget.formRegisterKey.currentContext!)
                    .showSnackBar(const SnackBar(
                        content: Text("Connexion au serveur impossible!")));
              } else if (apiResponse.containsKey("success") &&
                  apiResponse["success"]) {
                Navigator.pushAndRemoveUntil(
                    widget.formRegisterKey.currentContext!,
                    MaterialPageRoute(
                        builder: (context) => HomePage(
                            email: widget.email,
                            username: widget.username,
                            cookie: apiResponse["cookie"])),
                    (route) => false);
              } else {
                ScaffoldMessenger.of(widget.formRegisterKey.currentContext!)
                    .showSnackBar(
                        SnackBar(content: Text(apiResponse["message"])));
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please fill all fields ...")));
            }
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(const Color(0xFFD4AF37)),
          ),
          child: const Text(
            "Register",
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
