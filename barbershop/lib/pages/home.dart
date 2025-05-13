import 'package:barbershop/pages/adminListBarbers.dart';
import 'package:barbershop/pages/allBarber.dart';
import 'package:barbershop/pages/myAppointments.dart';
import 'package:barbershop/pages/profile.dart';
import 'package:barbershop/widgets/home_barber_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {super.key,
      required this.cookie,
      required this.email,
      required this.username,
      this.isAdmin = false});
  final String cookie;
  final String email;
  final String username;
  final bool isAdmin;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // ✅ Background image
          Positioned.fill(
            child: Image.asset(
              'assets/starting.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // ✅ Gradient overlay
          Positioned.fill(
            child: Container(
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
          ),

          // ✅ Foreground scrollable content
          Positioned.fill(
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),
                    ListTile(
                      leading: InkWell(
                          onTap: () {
                            if (widget.isAdmin) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdminSalonPage()));
                            }
                          },
                          child: Image.asset("assets/logo.png",
                              width: 80, height: 80)),
                      horizontalTitleGap: 5,
                      title: Text(
                        "Hey, ${widget.username}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: SizedBox(
                        width: 110,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfilePage(
                                      email: widget.email,
                                      username: widget.username,
                                      cookie: widget.cookie,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.person,
                                  size: 35, color: Color(0xFFD4AF37)),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AppointmentsPage(cookie: widget.cookie.split(';').first,),),);
                              },
                              icon: const Icon(Icons.calendar_today,
                                  size: 35, color: Color(0xFFD4AF37)),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ✅ Search bar
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search",
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // ✅ Nearby Barbershop Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Nearby Barbershop",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AllBarberPage()));
                            },
                            child: const Text(
                              'All>',
                              style: TextStyle(
                                color: Color(0xFFD4AF37),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2.35,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: HomeBarberCard(
                            isRanked: false,
                            distance: 0.9,
                            email: widget.email,
                            username: widget.username,
                            cookie: widget.cookie),
                      ),
                    ),

                    // ✅ Top Ranked Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Top Ranked",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AllBarberPage()));
                            },
                            child: const Text(
                              'All>',
                              style: TextStyle(
                                color: Color(0xFFD4AF37),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 2.35,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: HomeBarberCard(
                            isRanked: true,
                            distance: 0.9,
                            email: widget.email,
                            username: widget.username,
                            cookie: widget.cookie),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
