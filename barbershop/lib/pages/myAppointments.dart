import 'package:barbershop/apiCalls/getUserAppointments.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentsPage extends StatelessWidget {
  final String cookie;
  const AppointmentsPage({super.key, required this.cookie});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>?>(
      future: getUserAppointments(cookie),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          var appointments = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              var appointment = appointments[index];
              String isoDate = appointment["date"].toString();
              DateTime parsedDate = DateTime.parse(isoDate);
              String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);
              String formattedTime = DateFormat('HH:mm').format(parsedDate);

              return Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointment["barbershop"]["name"],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 20, color: Colors.grey),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                appointment["barbershop"]["location"],
                                style: const TextStyle(fontSize: 16, color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 20, color: Colors.grey),
                            const SizedBox(width: 6),
                            Text(
                              "Date : $formattedDate",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.access_time, size: 20, color: Colors.grey),
                            const SizedBox(width: 6),
                            Text(
                              "Heure : $formattedTime",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.cut, size: 20, color: Colors.grey),
                            const SizedBox(width: 6),
                            Text(
                              "Type de coupe : ${appointment["haircut"]}",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('Aucune donnée disponible.'));
        }
      },
    );
  }
}
