import 'dart:convert';
import 'package:barbershop/constants.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>>? book(String id, String date, String haircut, String cookie) async {
  const bookingUrl = "${Constants.baseUrl}api/bookAppointment";

  var request = http.MultipartRequest('POST', Uri.parse(bookingUrl))
    ..fields['barbershopId'] = id
    ..fields['date'] = date
    ..fields['haircut'] = haircut;

  // Ajouter le cookie dans les headers
  request.headers['Cookie'] = cookie.split(';').first;

  var response = await request.send();
  var responseData = await http.Response.fromStream(response);
  print(jsonDecode(responseData.body));
  return jsonDecode(responseData.body);
}

