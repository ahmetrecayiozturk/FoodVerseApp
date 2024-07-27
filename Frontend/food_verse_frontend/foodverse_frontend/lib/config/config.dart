const String BaseUrl = "http://192.168.1.103:3000/";
const String foodSaveApi = "foods";
const String foodSearchApi = "find-foods";
const String registrationApi = "registration";
const String loginApi = "login";
const String getsavedfood = "get-savedfoods";
const String savedFood = "saved-foods";
const String isuserexist = "isuser-exist";
const String getaddedfoods = "get-addedfoods";
const String getadderbyfood = "get-adderbyfood";
const String finfoodbyonlyingredient = "find-food-only-by-ingredient";

/*
import 'dart:io';

// Change to non-const and initialize it later.
String baseUrl = '';
const String foodSaveApi = "foods";
const String foodSearchApi = "find-foods";
const String registrationApi = "registration";
const String loginApi = "login";
const String getSavedFood = "get-savedfoods";
const String savedFood = "saved-foods";
const String isUserExist = "isuser-exist";
const String getAddedFoods = "get-addedfoods";
const String getAdderByFood = "get-adderbyfood";
const String findFoodByOnlyIngredient = "find-food-only-by-ingredient";

Future printIps() async {
  for (var interface in await NetworkInterface.list()) {
    // For demonstration: '== Interface: ${interface.name} =='
    for (var addr in interface.addresses) {
      // For demonstration: '${addr.address} ${addr.host} ${addr.isLoopback} ${addr.rawAddress} ${addr.type.name}'
    }
  }
}

Future<String> getBaseUrl() async {
  for (var interface in await NetworkInterface.list()) {
    // Use a logging framework instead of print
    // LoggingFramework.log('== Interface: ${interface.name} ==');
    for (var addr in interface.addresses) {
      // Remove the unused variable
      // var BaseUrl = '${addr.address} ${addr.host} ${addr.isLoopback} ${addr.rawAddress} ${addr.type.name}';
      var baseUrl = addr.address; // Simplified for demonstration
      return baseUrl;
    }
  }
  throw Exception('Unable to determine base URL');
}
      // Android Emulator'da localhost'a bağlanmak için

/*

Future<String> getBaseUrl() async {
  List<NetworkInterface> interfaces = await NetworkInterface.list(
    includeLoopback: false,
    type: InternetAddressType.IPv4,
  );

  if (interfaces.isEmpty) {
    // Android Emulator'da localhost'a bağlanmak için 10.0.2.2 kullanılır
    return '10.0.2.2';
  }

  NetworkInterface activeInterface = interfaces.firstWhere(
    (interface) =>
        interface.name.contains('wlan') && interface.addresses.isNotEmpty,
    orElse: () => interfaces.first,
  );

  return activeInterface.addresses.first.address;
}

Future<String> getBaseUrlWithPort() async {
  String ipAddress = await getBaseUrl();
  return 'http://$ipAddress:3000/';
}

// Example of initializing baseUrl at runtime
Future<void> initConfig() async {
  BaseUrl = await getBaseUrlWithPort();
  // Now baseUrl is initialized and can be used throughout the application.
}
/*import 'dart:io';
const String BaseUrl = getBaseUrl();
const String foodSaveApi = "foods";
const String foodSearchApi = "find-foods";
const String registrationApi = "registration";
const String loginApi = "login";
const String getsavedfood = "get-savedfoods";
const String savedFood = "saved-foods";
const String isuserexist = "isuser-exist";
const String getaddedfoods = "get-addedfoods";
const String getadderbyfood = "get-adderbyfood";
const String finfoodbyonlyingredient = "find-food-only-by-ingredient";

Future<String> getBaseUrl() async {
  List<NetworkInterface> interfaces = await NetworkInterface.list(
    includeLoopback: false,
    type: InternetAddressType.IPv4,
  );

  if (interfaces.isEmpty) {
    // Android Emulatorda localhost'a bağlanmak için 10.0.2.2 kullanılır
    return '10.0.2.2';
  }

  NetworkInterface activeInterface = interfaces.firstWhere(
    (interface) =>
        interface.name.contains('wlan') && interface.addresses.isNotEmpty,
    orElse: () => interfaces.first,
  );

  return activeInterface.addresses.first.address;
}

Future<String> getBaseUrlWithPort() async {
  String ipAddress = await getBaseUrl();
  return 'http://$ipAddress:3000/';
}
*/

*/



















/*
import 'dart:io';

const String foodSaveApi = "foods";
const String foodSearchApi = "find-foods";
const String registrationApi = "registration";
const String loginApi = "login";

Future<String> getBaseUrl() async {
  List<NetworkInterface> interfaces = await NetworkInterface.list(
    includeLoopback: false,
    type: InternetAddressType.IPv4,
  );

  if (interfaces.isEmpty) {
    return '10.0.2.2';
  }

  NetworkInterface activeInterface = interfaces.firstWhere(
    (interface) =>
        interface.name.contains('wlan') && interface.addresses.isNotEmpty,
    orElse: () => interfaces.first,
  );

  return activeInterface.addresses.first.address;
}

Future<String> getBaseUrlWithPort() async {
  String ipAddress = await getBaseUrl();
  return 'http://$ipAddress:3000/';
}
*/



















/*
import 'dart:io';

const String BASE_URL = "http://192.168.1.107:3000/";
const String foodSaveApi = "foods";
const String foodSearchApi = "find-foods";
const String registrationApi = "registration";
const String loginApi = "login";

Future<String> getBaseUrl() async {
  List<NetworkInterface> interfaces = await NetworkInterface.list(
    includeLoopback: false,
    type: InternetAddressType.IPv4,
  );

  NetworkInterface activeInterface = interfaces.firstWhere(
    (interface) =>
        interface.name.contains('wifi') && interface.addresses.isNotEmpty,
    orElse: () => InternetAddress('0.0.0.0') as NetworkInterface,
  );

  return activeInterface.addresses.first.address;
}

Future<String> getBaseUrlWithPort() async {
  String ipAddress = await getBaseUrl();
  return 'http://$ipAddress:3000/';
}
*/



















/*
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';

const String baseUrl = "http://192.168.1.107:3000/";
const String foodSaveApi = "foods";
const String foodSearchApi = "find-foods";
const String registrationApi = "registration";
const String loginApi = "login";

String getBaseUrl() {
  // Get the device IP address
  Future<String> _getDeviceIpAddress() async {
    List<NetworkInterface> interfaces = await NetworkInterface.list(
      includeLoopback: false,
      type: InternetAddressType.IPv4,
    );

    // Get the first active IPv4 address
    NetworkInterface activeInterface = interfaces.firstWhere(
      (interface) => interface.name.contains('wlan') && interface.addresses.isNotEmpty,
      orElse: () => NetworkInterface(
        name: 'localhost',
        addresses: [InternetAddress('127.0.0.1')],
        type: InternetAddressType.IPv4,
      ),
    );

    return activeInterface.addresses.first.address;
  }

  return 'http://${await _getDeviceIpAddress()}:3000';
}
*/

*/