import 'package:barbershop/apiCalls/book.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'home.dart';

class BookingPage extends StatefulWidget {
  final String barbershopId;
  final String cookie;
  final String email;
  final String username;
  const BookingPage({super.key, required this.barbershopId, required this.cookie, required this.email, required this.username});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  String selectedCut = '';

  final List<String> cuts = ['Dégradé', 'Classique', 'Tresse', 'Afro'];

  String mergeDateAndTime(String dateStr, String timeStr) {
    try {
      // Parse la date
      final dateParts = dateStr.split("-");
      final day = int.parse(dateParts[0]);
      final month = int.parse(dateParts[1]);
      final year = int.parse(dateParts[2]);

      // Parse de l'heure (format HH:mm)
      final time = TimeOfDay.fromDateTime(
        DateFormat.Hm().parse(timeStr),
      );

      final mergedDateTime = DateTime(year, month, day, time.hour, time.minute);
      return mergedDateTime.toIso8601String(); // Format API standard
    } catch (e) {
      debugPrint("Erreur fusion date/heure: $e");
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(onPressed: () {Navigator.pop(context);}, icon: const Icon(Icons.arrow_back, color: Colors.white,),),
      ),
      backgroundColor: Colors.black87,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Réservez pour une\ncoupe de cheveux",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              _buildReadOnlyField("Nom", "Lannister"),
              const SizedBox(height: 20),
              _buildReadOnlyField("Email", "mrhanderson@gmail.com"),
              const SizedBox(height: 20),
              _buildDateInput(context),
              const SizedBox(height: 20),
              _buildTimeInput(context),
              const SizedBox(height: 20),
              _buildDropdown(),
              const SizedBox(height: 20),
              _buildSalonField(),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107), // jaune
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Traitement
                      String formatedDateAndTime = mergeDateAndTime(dateController.text, timeController.text);
                      final apiResponse = await book(widget.barbershopId, formatedDateAndTime, selectedCut, widget.cookie);
                      if (apiResponse == null) {
                        ScaffoldMessenger.of(_formKey.currentContext!)
                            .showSnackBar(const SnackBar(
                            content: Text("Connexion au serveur impossible!")));
                      } else if (apiResponse.containsKey("success") &&
                          apiResponse["success"]) {
                        ScaffoldMessenger.of(_formKey.currentContext!)
                            .showSnackBar(
                            const SnackBar(content: Text("Rendez-vous pris avec succès!!!")));
                        Navigator.pushAndRemoveUntil(
                            _formKey.currentContext!,
                            MaterialPageRoute(builder: (context) => HomePage(email: widget.email, username: widget.username, cookie: widget.cookie,)),
                                (route) => false);
                      } else {
                        ScaffoldMessenger.of(_formKey.currentContext!)
                            .showSnackBar(
                            SnackBar(content: Text(apiResponse["message"])));
                      }
                    } else {
                      ScaffoldMessenger.of(_formKey.currentContext!)
                          .showSnackBar(const SnackBar(
                          content: Text("Please fill all fields ...")));
                    }
                  },
                  child: const Text(
                    "Réserver",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return TextFormField(
      initialValue: value,
      readOnly: true,
      style: const TextStyle(color: Colors.white70),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.grey[850],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildDateInput(BuildContext context) {
    return TextFormField(
      controller: dateController,
      readOnly: true,
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer une date';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Date",
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.grey[850],
        suffixIcon: const Icon(Icons.calendar_today, color: Colors.white),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          dateController.text = "${date.day}-${date.month}-${date.year}";
        }
      },
    );
  }

  Widget _buildTimeInput(BuildContext context) {
    return TextFormField(
      controller: timeController,
      readOnly: true,
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer une heure';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Heure",
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.grey[850],
        suffixIcon: const Icon(Icons.access_time, color: Colors.white),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onTap: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (time != null) {
          timeController.text = time.format(context);
        }
      },
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.grey[850],
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Sélectionnez une coupe';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Type de coupe",
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.grey[850],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      value: selectedCut.isEmpty ? null : selectedCut,
      items: cuts
          .map((cut) =>
          DropdownMenuItem(value: cut, child: Text(cut, style: const TextStyle(color: Colors.white))))
          .toList(),
      onChanged: (val) {
        setState(() {
          selectedCut = val!;
        });
      },
    );
  }

  Widget _buildSalonField() {
    return TextFormField(
      initialValue: widget.barbershopId,
      readOnly: true,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: "Salon sélectionné",
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.grey[850],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
