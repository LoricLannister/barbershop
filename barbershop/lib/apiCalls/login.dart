import 'dart:convert';
import 'package:barbershop/constants.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> login(String email, String password) async {
  const loginUrl = "${Constants.baseUrl}api/login";
  var request = http.MultipartRequest('POST', Uri.parse(loginUrl))
    ..fields['email'] = email
    ..fields['password'] = password;

  var response = await request.send();
  var responseData = await http.Response.fromStream(response);

  var header = (responseData.headers)["set-cookie"];
  header = header?.split('Secure,').last;
  var body = jsonDecode(responseData.body) as Map<String, dynamic>;
  body.addAll({"cookie": header});

  return body;
}

