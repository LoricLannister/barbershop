import 'package:barbershop/apiCalls/logout.dart';
import 'package:barbershop/pages/starting.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key, required this.cookie});
  final String cookie;

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: InkWell(
        onTap: () async {
          final apiResponse = await logout(widget.cookie);
          if (apiResponse == null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(
                content: Text("Connexion au serveur impossible!")));
          } else if (apiResponse.containsKey("success") &&
              apiResponse["success"]) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const StartingPage()),
                    (route) => false);
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(
                SnackBar(content: Text(apiResponse["message"])));
          }
        },
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFD4AF37),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.black87,
            ),
            title: Text(
              "Logout",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
