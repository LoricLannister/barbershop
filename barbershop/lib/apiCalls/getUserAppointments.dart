import 'dart:convert';

import 'package:barbershop/constants.dart';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>>? getUserAppointments(cookie) async {
  const getuserAppointmentsUrl = "${Constants.baseUrl}api/userAppointments";
  final response = await http.get(Uri.parse(getuserAppointmentsUrl), headers: {"Cookie": cookie});

  List<dynamic> data = json.decode(response.body);
  return data.map((e) => e as Map<String, dynamic>).toList();
}