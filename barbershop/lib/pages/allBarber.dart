import 'package:flutter/material.dart';

class AllBarberPage extends StatefulWidget {
  const AllBarberPage({super.key});

  @override
  State<AllBarberPage> createState() => _AllBarberPageState();
}

class _AllBarberPageState extends State<AllBarberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFFD4AF37),
          ),
        ),
        title: const Text(
          "All availables barbers",
          style: TextStyle(
            color: Color(0xFFD4AF37),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.black87,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: MediaQuery.of(context).size.height*0.175,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1.5),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height*0.15,
                        width: 150,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/barbershopEg.jpg"),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ],
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
