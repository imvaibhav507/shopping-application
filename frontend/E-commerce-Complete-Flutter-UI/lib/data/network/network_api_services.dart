import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/core/errors/app_exceptions.dart';
import 'base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {

  @override
  Future getApi(String url) async {
    dynamic jsonResponse;
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token').toString();
    try {
      final response = await http.get(
          Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      ).timeout(const Duration(seconds: 60));
      jsonResponse = returnResponse(response);
    }on SocketException {
      throw InternetException('');
    }on RequestTimedOutException {
      throw RequestTimedOutException('');
    }
    return jsonResponse;
  }

  @override
  Future postApi(String url, dynamic data) async {
    dynamic jsonResponse;
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token').toString();
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 60));
      jsonResponse = returnResponse(response);
    }on SocketException {
      throw InternetException('No internet available');
    }on RequestTimedOutException {
      throw RequestTimedOutException('Request timed out');
    }
    return jsonResponse;
  }

  @override
  Future authApi(String url, dynamic data) async {
    dynamic jsonResponse;

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 60));
      jsonResponse = returnResponse(response);
    }on SocketException {
      throw InternetException('No internet available');
    }on RequestTimedOutException {
      throw RequestTimedOutException('Request timed out');
    }
    return jsonResponse;
  }


  @override
  Future uploadImageApi(String url, List<XFile> imageFiles, String filename) async {

    SharedPreferences sp = await SharedPreferences.getInstance();
    String token = await sp.get('token').toString();
    var multipartFiles = <http.MultipartFile>[];
    for (var imageFile in imageFiles) {
      var multipartFile = http.MultipartFile.fromBytes(
        filename, // Replace with your image field name in the API
        await imageFile.readAsBytes(),
        filename: imageFile.path.split('/').last,
      );
      multipartFiles.add(multipartFile);
    }

    dynamic jsonResponse;
    try {
      var request = http.MultipartRequest('PATCH', Uri.parse(url));
      request.headers['Authorization'] = 'Bearer ${token}';

      // Add the image file
      request.files.addAll(multipartFiles);

      final streamedResponse = await request.send().timeout(const Duration(seconds: 120));
      final response = await streamedResponse.stream.bytesToString();
      jsonResponse = jsonDecode(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimedOutException {
      throw RequestTimedOutException('');
    }
    return jsonResponse;
  }

  @override
  Future patchApi(String url,dynamic data) async {

    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');
    print(token);
    dynamic jsonResponse;
    try{
      final response = await http.patch(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
        body: jsonEncode(data)
      ).timeout(const Duration(seconds: 60));
      jsonResponse = returnResponse(response);
    }on SocketException {
      throw InternetException('No internet available');
    }on RequestTimedOutException {
      throw RequestTimedOutException('Request timed out');
    }
    return jsonResponse;
  }

  @override
  Future deleteApi(String url,dynamic data) async {

    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');
    dynamic jsonResponse;
    try{
      final response = await http.delete(
          Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token"
          },
          body: jsonEncode(data)
      ).timeout(const Duration(seconds: 60));
      jsonResponse = returnResponse(response);
    }on SocketException {
      throw InternetException('No internet available');
    }on RequestTimedOutException {
      throw RequestTimedOutException('Request timed out');
    }
    return jsonResponse;
  }

  dynamic returnResponse(http.Response response) {
    switch(response.statusCode) {
      case 200 :
        dynamic res = jsonDecode(response.body);
        return res;
      case 404 :
        throw InvalidUrlException('');
      default : throw FetchDataException('');
    }
  }

  @override
  Future putApi(String url, data) async {
    dynamic jsonResponse;
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token').toString();
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 60));
      jsonResponse = returnResponse(response);
    }on SocketException {
      throw InternetException('No internet available');
    }on RequestTimedOutException {
      throw RequestTimedOutException('Request timed out');
    }
    return jsonResponse;
  }



}