import 'dart:convert';
import 'package:barbershop/constants.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>>? logout(String cookie) async {
  const logoutUrl = "${Constants.baseUrl}api/logout";
  final response = await http
      .get(Uri.parse(logoutUrl), headers: {"Cookie": cookie.split(';').first});
  print(response.body);
  return json.decode(response.body);
}
