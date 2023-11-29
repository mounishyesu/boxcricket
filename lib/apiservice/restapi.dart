import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class URLS {
  static const String BASE_URL = 'https://splcrickets.com/api';
}

class Headers1 {
  static const Map<String, String> headers1 = {
    "Content-type": "application/json"
  };
}

class ApiService {

  static Future otpPostCall(
    url,
    body,
  ) async {
    try {
      final response = await http.post(Uri.parse('${URLS.BASE_URL}/${url}'),
          headers: {'x-api-key': 'splcricket'}, body: body);
      print(HttpHeaders.requestHeaders);
      print('${URLS.BASE_URL}/${url}');
      print(response.statusCode);
      return response;
    } catch (e) {
      return e;
    }
  }

  static Future get(
    url,
  ) async {
    try {
      final response = await http.get(Uri.parse('${URLS.BASE_URL}/${url}'),
          headers: {'x-api-key': 'splcricket'});
      print(HttpHeaders.requestHeaders);
      print('${URLS.BASE_URL}/${url}');
      print(response.statusCode);
      return response;
    } catch (e) {
      return e;
    }
  }

  static Future post(url, body) async {
    try {
      final response = await http.post(Uri.parse('${URLS.BASE_URL}/${url}'),
          headers: {
            'x-api-key': 'splcricket'
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

  static Future<String> registerForm(
    String url,
    String teamName,
    String captainName,
    String captainMob,
    String captainAge,
    String captainAadhar,
    String captainAddress,
    String panchayathiName,
    String mandalName,
    String districtName,
    String aadharFrontfilepath,
    String aadharBackfilepath,
    String profiefilepath,
  ) async {
    var postUri = Uri.parse('${URLS.BASE_URL}/$url');

    http.MultipartRequest request = http.MultipartRequest("POST", postUri);

    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      'x-api-key': 'splcricket'
    };
    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath('profile_image', profiefilepath);
    http.MultipartFile multipartFile1 =
        await http.MultipartFile.fromPath('aadhar_front', aadharFrontfilepath);
    http.MultipartFile multipartFile2 =
        await http.MultipartFile.fromPath('aadhar_back', aadharBackfilepath);

    request.files.add(multipartFile);
    request.files.add(multipartFile1);
    request.files.add(multipartFile2);
    request.headers.addAll(headers);

    request.fields["team_name"] = teamName;
    request.fields["team_captain"] = captainName;
    request.fields["captain_mobile"] = captainMob;
    request.fields["age"] = captainAge;
    request.fields["aadhar"] = captainAadhar;
    request.fields["address"] = captainAddress;
    request.fields["panchayathi"] = panchayathiName;
    request.fields["mandalam"] = mandalName;
    request.fields["district"] = districtName;

    http.StreamedResponse response = await request.send();

    return response.stream.bytesToString();
  }


  static Future<String> playerRegisterForm(
      String url,
      String teamId,
      String playerName,
      String playerSpecialization,
      String playerMobile,
      String playerAge,
      String playerAadhar,
      String playerShirtsize,
      String playerJersey,
      String profiefilepath,
      ) async {
    var postUri = Uri.parse('${URLS.BASE_URL}/$url');

    http.MultipartRequest request = http.MultipartRequest("POST", postUri);

    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      'x-api-key': 'splcricket'
    };
    http.MultipartFile multipartFile =
    await http.MultipartFile.fromPath('profile_image', profiefilepath);

    request.files.add(multipartFile);
    request.headers.addAll(headers);

    request.fields["team_id"] = teamId;
    request.fields["player_name"] = playerName;
    request.fields["player_specialization"] = playerSpecialization;
    request.fields["player_mobile"] = playerMobile;
    request.fields["player_age"] = playerAge;
    request.fields["player_aadhar"] = playerAadhar;
    request.fields["player_shirt_size"] = playerShirtsize;
    request.fields["player_jersey"] = playerJersey;

    http.StreamedResponse response = await request.send();

    return response.stream.bytesToString();
  }

}
