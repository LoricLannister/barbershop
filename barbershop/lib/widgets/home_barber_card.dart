import 'package:barbershop/pages/booking.dart';
import 'package:flutter/material.dart';
import 'package:barbershop/apiCalls/getBarbershops.dart';

class HomeBarberCard extends StatelessWidget {
  final bool isRanked;
  final double distance;
  final String cookie;
  final String username;
  final String email;
  const HomeBarberCard({
    super.key,
    required this.isRanked,
    required this.distance,
    required this.cookie, required this.username, required this.email,
  });

  bool isBarberOpen(String openAt, String closeAt) {
    final now = TimeOfDay.now();

    TimeOfDay parseTime(String timeStr) {
      final parts = timeStr.split(':');
      return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    }

    final open = parseTime(openAt);
    final close = parseTime(closeAt);

    bool isAfterOpen = now.hour > open.hour ||
        (now.hour == open.hour && now.minute >= open.minute);
    bool isBeforeClose = now.hour < close.hour ||
        (now.hour == close.hour && now.minute < close.minute);

    return isAfterOpen && isBeforeClose;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>?>(
      future: getBarbershops(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          // Utilise les données récupérées
          var barbershops = snapshot.data!;
          List<Widget> cards = [];
          for (var barber in barbershops) {
            cards.add(Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Container(
                height: MediaQuery.of(context).size.height / 2.35,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  border: Border.all(
                      color: Colors.grey.withOpacity(0.3), width: 1.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.3), width: 1.5),
                          image: const DecorationImage(
                              image: AssetImage("assets/barbershopEg.jpg"),
                              fit: BoxFit.cover),
                        ),
                        child: isRanked
                            ? Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      height: 25,
                                      width: 45,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFD4AF37),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.black,
                                            size: 15,
                                          ),
                                          const SizedBox(width: 2),
                                          Text(
                                            "${barber["rate"]}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 12,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: [
                          Text(
                            isBarberOpen(barber["openAt"], barber["closeAt"])
                                ? "OPEN NOW"
                                : "CLOSED NOW",
                            style: TextStyle(
                              color: isBarberOpen(
                                      barber["openAt"], barber["closeAt"])
                                  ? const Color(0xFFD4AF37)
                                  : Colors.redAccent,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "from ${barber["openAt"]} to ${barber["closeAt"]}",
                            style: TextStyle(
                              color: Colors.grey.withOpacity(0.5),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        barber['name'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, bottom: 8),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.gps_fixed,
                            color: Color(0xFFD4AF37),
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "$distance km",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BookingPage(email: email, username: username,barbershopId: barber["id"], cookie: cookie,)));
                        },
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.5,
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4AF37),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              "BOOK NOW",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
          }
          return Row(children: cards);
        } else {
          return const Center(child: Text('Aucune donnée disponible.'));
        }
      },
    );
  }
}
