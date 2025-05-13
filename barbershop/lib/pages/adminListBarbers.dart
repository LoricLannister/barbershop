import 'package:barbershop/pages/addSaloon.dart';
import 'package:barbershop/pages/saloonAppointment.dart';
import 'package:flutter/material.dart';

class AdminSalonPage extends StatelessWidget {
  final List<Map<String, dynamic>> salons = [
    {
      'nom': 'ZEN BARBER',
      'adresse': 'rue du campanile, 1200 bruxelles',
      'horaire': '09:00 - 17:00',
      'note': 4.0,
      'ouvert': false,
      'image': 'assets/barbershopEg.jpg',
    },
    {
      'nom': 'BARBER 237',
      'adresse': '52 reddington, Port gentil',
      'horaire': '09:00 - 18:00',
      'note': 4.0,
      'ouvert': false,
      'image': 'assets/barbershopEg.jpg',
    },
  ];

   AdminSalonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: const Text("Liste des Salons", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              icon: const Icon(Icons.add),
              label: const Text("Ajouter un Salon"),
              onPressed: () {
                // Action pour ajouter un salon
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const AddSalonPage()));
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: salons.length,
                itemBuilder: (context, index) {
                  final salon = salons[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SalonAppointmentsPage(salonId: "")));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                            child: Image.asset(salon['image'], fit: BoxFit.cover),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      salon['nom'],
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: salon['ouvert'] ? Colors.green[100] : Colors.red[100],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(Icons.circle, size: 10, color: salon['ouvert'] ? Colors.green : Colors.red),
                                          const SizedBox(width: 5),
                                          Text(salon['ouvert'] ? "Ouvert" : "Fermé",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: salon['ouvert'] ? Colors.green : Colors.red,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                                    const SizedBox(width: 5),
                                    Expanded(child: Text(salon['adresse'], style: const TextStyle(fontSize: 13))),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                                    const SizedBox(width: 5),
                                    Text(salon['horaire'], style: const TextStyle(fontSize: 13)),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Icon(Icons.star, size: 16, color: Colors.grey),
                                    const SizedBox(width: 5),
                                    Text("Note : ${salon['note']}/5", style: const TextStyle(fontSize: 13)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
