import 'dart:convert';
import 'package:barbershop/constants.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> register(String username, String email, String password) async {
  const registerUrl = "${Constants.baseUrl}api/register";
  var request = http.MultipartRequest('POST', Uri.parse(registerUrl))
    ..fields['username'] = username
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
