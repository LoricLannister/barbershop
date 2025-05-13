import 'package:flutter/material.dart';

class AddSalonPage extends StatefulWidget {
  const AddSalonPage({super.key});

  @override
  State<AddSalonPage> createState() => _AddSalonPageState();
}

class _AddSalonPageState extends State<AddSalonPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _openingTimeController = TextEditingController();
  final TextEditingController _closingTimeController = TextEditingController();

  TimeOfDay? _openingTime;
  TimeOfDay? _closingTime;

  Future<void> _selectTime(bool isOpening) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        final formattedTime = picked.format(context);
        if (isOpening) {
          _openingTime = picked;
          _openingTimeController.text = formattedTime;
        } else {
          _closingTime = picked;
          _closingTimeController.text = formattedTime;
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5)),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.location_pin, color: Colors.pink, size: 30),
              const SizedBox(height: 10),
              const Text(
                "Ajouter un\nnouveau Salon",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Nom du salon
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: "Nom du salon",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 10),

              // Adresse
              TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  hintText: "Adresse",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 10),

              // Heures
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectTime(true),
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: _openingTimeController,
                          decoration: InputDecoration(
                            hintText: _openingTime?.format(context) ?? "--:--",
                            suffixIcon: const Icon(Icons.access_time),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            labelText: "Heure d'ouverture",
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectTime(false),
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: _closingTimeController,
                          decoration: InputDecoration(
                            hintText: _closingTime?.format(context) ?? "--:--",
                            suffixIcon: const Icon(Icons.access_time),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            labelText: "Heure de fermeture",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Bouton
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F3554),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    // 👉 Appelle ta logique backend ici
                    debugPrint("Nom: ${_nameController.text}");
                    debugPrint("Adresse: ${_addressController.text}");
                    debugPrint("Heure d'ouverture: ${_openingTime?.format(context)}");
                    debugPrint("Heure de fermeture: ${_closingTime?.format(context)}");
                  },
                  child: const Text("Créer le Salon", style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
