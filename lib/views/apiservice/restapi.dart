import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class URLS {

  static const String BASE_URL = 'https://vinsretail.com/api/Users';

}

class Headers1 {
  static const Map<String, String> headers1 = {
    "Content-type": "application/json"
  };
}

class ApiService {

  static Future otpPostCall(url, body,) async {
    try {
      final response = await http.post(Uri.parse('${URLS.BASE_URL}/${url}'),
          headers: {
            "Content-type": "application/json",
            'x-api-key': 'vinsretail_grocery'
          },
          body: body);
      print(HttpHeaders.requestHeaders);
      print('${URLS.BASE_URL}/${url}');
      print(response.statusCode);
      return response;
    } catch (e) {
      return e;
    }
  }

  static Future<String> postCall(String url, Map<String, dynamic> body) async {
    try {
      final encodedBody = body.map((key, value) =>
          MapEntry(key, value is List ? value.join(',') : value));
      // log('try......');
      final Uri path = Uri.parse('${URLS.BASE_URL}/$url');
      // log(path.toString());
      final response = await post(path,
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            'x-api-key': 'vinsretail_grocery'
          },
          body: encodedBody);
      if (response.statusCode == 200) {
        // log(response.body.toString());
        return response.body;
      }
      // print(path.toString());
      // log(response.body);

      // return response.body;

      // }
    } catch (e) {
      log('something went.......');
      log('registration Error: $e');
    }
    return "";
  }

  static Future postAttachment(url, body, token) async {
    try {
      final response = await http.post(Uri.parse('${URLS.BASE_URL}/${url}'),
          headers: {
            "Content-Type": "multipart/form-data",
            "Authorization": "Bearer " + token
          },
          body: body);
      print(HttpHeaders.requestHeaders);
      print('${URLS.BASE_URL}/${url}');
      print(response.statusCode);
      return response;
    } catch (e) {
      return e;
    }
  }

  static Future get(url, token) async {
    try {
      final response = await http.get(Uri.parse('${URLS.BASE_URL}/${url}'),
          headers: {
            "Content-type": "application/json",
            "Authorization": "Bearer " + token
          });
      print(HttpHeaders.requestHeaders);
      print('${URLS.BASE_URL}/${url}');
      print(response.statusCode);
      return response;
    } catch (e) {
      return e;
    }
  }
}
