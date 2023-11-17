import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class URLS {
  // static const String BASE_URL = 'https://gopauatservices.isa.ae/api';

  static const String BASE_URL = 'https://gopauatservices.isa.ae/api';



  static const String BASE_URL1 = 'https://gopauatservices.isa.ae';

}

class Headers1 {
  static const Map<String, String> headers1 = {
    "Content-type": "application/json"
  };
}

class ApiService {
  static Future login(username, password) async {
    try {
      final response = await http.post(
        Uri.parse('${URLS.BASE_URL1}/asms2011mobtoken'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding: Encoding.getByName('utf-8'),
        body: {
          "username": username,
          "password": password,
          "grant_type": "password"
        },
      );
      print('${URLS.BASE_URL1}/asms2011mobtoken');
      print(response.statusCode);
      return response;
    } catch (e) {
      return e;
    }
  }

  static Future post(url, body, token) async {
    try {
      final response = await http.post(Uri.parse('${URLS.BASE_URL}/${url}'),
          headers: {
            "Content-type": "application/json",
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
