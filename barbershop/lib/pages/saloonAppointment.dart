import 'package:flutter/material.dart';

class SalonAppointmentsPage extends StatelessWidget {
  final String salonId;

  // 👇 tu reçois l'ID du salon sélectionné
  const SalonAppointmentsPage({super.key, required this.salonId});

  // fake data pour la démo (à remplacer avec un appel à la base)
  final List<Map<String, dynamic>> fakeAppointments = const [
    {
      "name": "mlan",
      "email": "mlan@gmail.com",
      "date": "30/04/2025",
      "hour": "02:00",
      "style": "Dégradé",
      "avatar": "assets/avatar.jpg"
    },
    {
      "name": "mlan",
      "email": "mlan@gmail.com",
      "date": "16/05/2025",
      "hour": "02:00",
      "style": "Dégradé",
      "avatar": "assets/avatar.jpg"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rendez-vous programmés'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text("Retour à l'admin"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: fakeAppointments.length,
                itemBuilder: (context, index) {
                  final rdv = fakeAppointments[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(rdv['avatar']),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  rdv['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text("Email : ${rdv['email']}"),
                                Text("Date : ${rdv['date']}"),
                                Text("Heure : ${rdv['hour']}"),
                                Text("Coupe : ${rdv['style']}"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
