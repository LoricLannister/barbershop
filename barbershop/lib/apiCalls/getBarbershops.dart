import 'dart:convert';
import 'package:barbershop/constants.dart';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>>? getBarbershops() async {
  const barbershopsUrl = "${Constants.baseUrl}api/barbershops";
  final response = await http.get(Uri.parse(barbershopsUrl));

  List<dynamic> data = json.decode(response.body);
  return data.map((e) => e as Map<String, dynamic>).toList();
}