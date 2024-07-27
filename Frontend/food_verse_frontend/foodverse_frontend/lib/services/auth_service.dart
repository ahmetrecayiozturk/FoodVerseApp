import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:foodverse_frontend/config/config.dart'; // Ensure this is correctly imported
import 'package:logging/logging.dart';

final Logger logger = Logger('AuthService');

class AuthService {
  Future<bool> registerUser(String email, String password) async {
    logger.info("Registering Process");
    var regBody = {"email": email, "password": password};
    try {
      var response = await http.post(
        Uri.parse(BaseUrl + registrationApi),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      if (response.statusCode == 200) {
        logger.info("Registration Successful");
        logger.info("Status Code: ${response.statusCode}");
        logger.info("Response Body: ${response.body}");
        return true;
      } else {
        // Log error details for non-200 responses
        logger.warning("Registration Failed");
        logger.warning("Status Code: ${response.statusCode}");
        logger.warning("Response Body: ${response.body}");
        return false;
      }
    } catch (e) {
      // Catch and log any exceptions during the HTTP request
      logger.severe("An error occurred during registration: $e");
      return false;
    }
  }

  Future<bool> loginUser(String email, String password) async {
    var regBody = {"email": email, "password": password};

    try {
      var response = await http.post(
        Uri.parse(BaseUrl + loginApi),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      if (response.statusCode == 200) {
        logger.info("Login Successful");
        logger.info("Status Code: ${response.statusCode}");
        logger.info("Response Body: ${response.body}");
        return true;
      } else {
        logger.warning("Login Failed");
        logger.warning("Status Code: ${response.statusCode}");
        logger.warning("Response Body: ${response.body}");
        return false;
      }
    } catch (e) {
      logger.severe("An error occurred during login: $e");
      return false;
    }
  }

  Future<String> updateEmail(String email, String newEmail) async {
    var regBody = {"email": email, "newemail": newEmail};
    final response = await http.post(
      Uri.parse('${BaseUrl}update-email'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(regBody),
    );
    return response.body;
  }
}

/*
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:foodverse_frontend/config/config.dart'; // Ensure this is correctly imported
import 'package:logging/logging.dart';

final Logger logger = Logger('AuthService');

class AuthService {
  Future<bool> registerUser(String email, String password) async {
    logger.info("Registering Process");
    var regBody = {"email": email, "password": password};
    var host = await getBaseUrl();
    print("http://" + host + registrationApi);
    print(host + "budur host budurrrr");

    try {
      var response = await http.post(
        Uri.parse("http://" + host + registrationApi),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      if (response.statusCode == 200) {
        logger.info("Registration Successful");
        logger.info("Status Code: ${response.statusCode}");
        logger.info("Response Body: ${response.body}");
        return true;
      } else {
        // Log error details for non-200 responses
        logger.warning("Registration Failed");
        logger.warning("Status Code: ${response.statusCode}");
        logger.warning("Response Body: ${response.body}");
        return false;
      }
    } catch (e) {
      // Catch and log any exceptions during the HTTP request
      logger.severe("An error occurred during registration: $e");
      return false;
    }
  }

  Future<bool> loginUser(String email, String password) async {
    var host = await getBaseUrl();
    print(host + "budur host budurrrr");
    logger.info("Login Process");
    print("http://" + host + loginApi);
    var regBody = {"email": email, "password": password};

    var response = await http.post(
      Uri.parse("http://" + host + loginApi),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(regBody),
    );

    if (response.statusCode == 200) {
      logger.info("Login Successful");
      logger.info("Status Code: ${response.statusCode}");
      logger.info("Response Body: ${response.body}");
      return true;
    } else {
      logger.warning("Login Failed");
      logger.warning("Status Code: ${response.statusCode}");
      logger.warning("Response Body: ${response.body}");
      return false;
    }
  }
}
*/












/*
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:foodverse_frontend/config/config.dart';

class AuthService {
  Future<bool> registerUser(String email, String password) async {
    print("Registering Process");
    var regBody = {"email": email, "password": password};

    var response = await http.post(
      Uri.parse(BaseUrl + registrationApi),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(regBody),
    );

    if (response.statusCode == 200) {
      print("Kayıt Başarılı");
      print(response.statusCode);
      print(response.body);
      return true;
    } else {
      print(response.statusCode);
      print(response.body);
      return false;
    }
  }

  Future<bool> loginUser(String email, String password) async {
    print("Login Process");
    var regBody = {"email": email, "password": password};

    var response = await http.post(
      Uri.parse(BaseUrl + loginApi),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(regBody),
    );

    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response.body);
      print("Giriş Başarılı");
      return true;
    } else {
      print(response.statusCode);
      print(response.body);
      return false;
    }
  }
}
*/